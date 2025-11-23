int convertTime(char *current, char *correct) {
    int currH = (current[0] - '0') * 10 + (current[1] - '0');
    int currM = (current[3] - '0') * 10 + (current[4] - '0');
    int corrH = (correct[0] - '0') * 10 + (correct[1] - '0');
    int corrM = (correct[3] - '0') * 10 + (correct[4] - '0');

    int currentTotalMinutes = currH * 60 + currM;
    int correctTotalMinutes = corrH * 60 + corrM;

    int diff = correctTotalMinutes - currentTotalMinutes;
    if (diff < 0) {
        diff += 1440;
    }

    int operations = 0;
    int timeUnits[] = {60, 15, 5, 1};

    for (int i = 0; i < 4; i++) {
        operations += diff / timeUnits[i];
        diff %= timeUnits[i];
    }

    return operations;
}