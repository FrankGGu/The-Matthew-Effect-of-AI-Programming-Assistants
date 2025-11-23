int numberOfRounds(char *loginTime, char *logoutTime) {
    int loginHour = (loginTime[0] - '0') * 10 + (loginTime[1] - '0');
    int loginMinute = (loginTime[3] - '0') * 10 + (loginTime[4] - '0');
    int logoutHour = (logoutTime[0] - '0') * 10 + (logoutTime[1] - '0');
    int logoutMinute = (logoutTime[3] - '0') * 10 + (logoutTime[4] - '0');

    int loginTotalMinutes = loginHour * 60 + loginMinute;
    int logoutTotalMinutes = logoutHour * 60 + logoutMinute;

    if (logoutTotalMinutes < loginTotalMinutes) {
        logoutTotalMinutes += 24 * 60;
    }

    loginTotalMinutes = (loginTotalMinutes + 14) / 15 * 15;
    logoutTotalMinutes = logoutTotalMinutes / 15 * 15;

    if (logoutTotalMinutes < loginTotalMinutes) {
        return 0;
    }

    return (logoutTotalMinutes - loginTotalMinutes) / 15;
}