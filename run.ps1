
Connect-VIServer -Server "vcenter.com" -User "zilzar" -Password "password"

# Target Portgroup name
$TargetPortgroup = "PG-02_ForwarFW"

# TXT path
$TXTFilePath = "C:\VMList.txt"

$VMList = Get-Content -Path $TXTFilePath

foreach ($VM in $VMList) {
    try {
        # Get VM Name
        $VMObject = Get-VM -Name $VM

        # Get the VM's network adapters and switch them to the target portgroup
        $Adapter = $VMObject | Get-NetworkAdapter
        $Adapter | Set-NetworkAdapter -NetworkName $TargetPortgroup -Confirm:$false

        Write-Host "VM '$VM' successfully moved to portgroup '$TargetPortgroup'" -ForegroundColor Green
    }
    catch {
        Write-Host "Error moving VM '$VM': $_" -ForegroundColor Red
    }
}

