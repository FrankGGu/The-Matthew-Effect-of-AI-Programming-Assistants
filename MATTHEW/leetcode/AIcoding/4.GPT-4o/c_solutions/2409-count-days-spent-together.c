int countDaysTogether(char * arriveAlice, char * leaveAlice, char * arriveBob, char * leaveBob) {
    int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int totalDays = 0;

    int arriveA = (arriveAlice[0] - '0') * 10 + (arriveAlice[1] - '0');
    int leaveA = (leaveAlice[0] - '0') * 10 + (leaveAlice[1] - '0');
    int arriveB = (arriveBob[0] - '0') * 10 + (arriveBob[1] - '0');
    int leaveB = (leaveBob[0] - '0') * 10 + (leaveBob[1] - '0');

    int monthA = (arriveAlice[3] - '0') * 10 + (arriveAlice[4] - '0');
    int monthB = (arriveBob[3] - '0') * 10 + (arriveBob[4] - '0');

    int startA = (monthA - 1) * 100 + arriveA;
    int endA = (monthA - 1) * 100 + leaveA;
    int startB = (monthB - 1) * 100 + arriveB;
    int endB = (monthB - 1) * 100 + leaveB;

    int start = startA > startB ? startA : startB;
    int end = endA < endB ? endA : endB;

    if (start <= end) {
        for (int i = 1; i < monthA; i++) totalDays += daysInMonth[i];
        totalDays += leaveA;
        for (int i = 1; i < monthB; i++) totalDays -= daysInMonth[i];
        totalDays -= (31 - arriveB);
        return totalDays + 1;
    }

    return 0;
}