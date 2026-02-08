int numberOfRounds(char* loginTime, char* logoutTime) {
    int login_h = (loginTime[0] - '0') * 10 + (loginTime[1] - '0');
    int login_m = (loginTime[3] - '0') * 10 + (loginTime[4] - '0');
    int logout_h = (logoutTime[0] - '0') * 10 + (logoutTime[1] - '0');
    int logout_m = (logoutTime[3] - '0') * 10 + (logoutTime[4] - '0');

    int login_total = login_h * 60 + login_m;
    int logout_total = logout_h * 60 + logout_m;

    if (logout_total < login_total) {
        logout_total += 24 * 60;
    }

    int start_round = (login_total + 14) / 15;
    int end_round = logout_total / 15;

    return (end_round - start_round) > 0 ? (end_round - start_round) : 0;
}