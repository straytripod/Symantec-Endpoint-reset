rem Dependancy: psexec.exe
rem Runs commands remotly to restart SEP services and update. Need to set the script location and SEP Password before running.
@echo off
set /p cname=Enter [Computer Name]:
set compath=[script location]
echo ---------------------------
echo Stopping SEP Master service
echo -------------------------------------------------
echo This will hang on first run due to EULA Acceptace
echo Run the script agian and it will work.
echo -------------------------------------------------
%compath%\psexec.exe -accepteula -s \\%cname% "C:\Program Files (x86)\Symantec\Symantec Endpoint Protection\smc.exe" -p [password] -stop
echo -----------------------------------------------
echo Waiting 5 seconds for service stop to complete
echo ------------------------------------------------
timeout 5
echo ---------------------------
echo Starting SEP Master service
echo ---------------------------
%compath%\psexec.exe -accepteula -s \\%cname% "C:\Program Files (x86)\Symantec\Symantec Endpoint Protection\smc.exe" -start
echo ------------------------------------------------
echo Waiting 10 seconds for service start to complete
echo ------------------------------------------------
timeout 10
echo --------------------------
echo Starting SEP LIVE Update
echo --------------------------
%compath%\psexec.exe -accepteula -s \\%cname% "C:\Program Files (x86)\Symantec\Symantec Endpoint Protection\sepliveupdate.exe"
pause
