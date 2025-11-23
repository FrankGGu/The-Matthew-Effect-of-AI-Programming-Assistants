int countTime(char * time) {
    int hours = 1, minutes = 1;

    if (time[0] == '?' && time[1] == '?') {
        hours = 24;
    } else if (time[0] == '?') {
        if (time[1] - '0' < 4) {
            hours = 3;
        } else {
            hours = 2;
        }
    } else if (time[1] == '?') {
        if (time[0] - '0' == 2) {
            hours = 4;
        } else {
            hours = 10;
        }
    }

    if (time[3] == '?' && time[4] == '?') {
        minutes = 60;
    } else if (time[3] == '?') {
        minutes = 6;
    } else if (time[4] == '?') {
        minutes = 10;
    }

    return hours * minutes;
}