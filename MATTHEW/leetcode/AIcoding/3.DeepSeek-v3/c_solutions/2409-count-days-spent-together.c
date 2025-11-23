int daysInMonth(int month) {
    int days[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    return days[month - 1];
}

int dateToDays(char* date) {
    int month = (date[0] - '0') * 10 + (date[1] - '0');
    int day = (date[3] - '0') * 10 + (date[4] - '0');
    int totalDays = 0;
    for (int i = 1; i < month; i++) {
        totalDays += daysInMonth(i);
    }
    totalDays += day;
    return totalDays;
}

int countDaysTogether(char* arriveAlice, char* leaveAlice, char* arriveBob, char* leaveBob) {
    int aliceArrive = dateToDays(arriveAlice);
    int aliceLeave = dateToDays(leaveAlice);
    int bobArrive = dateToDays(arriveBob);
    int bobLeave = dateToDays(leaveBob);

    int start = aliceArrive > bobArrive ? aliceArrive : bobArrive;
    int end = aliceLeave < bobLeave ? aliceLeave : bobLeave;

    if (start > end) return 0;
    return end - start + 1;
}