#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int daysInMonth(int month, int year) {
    int days[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (month == 2 && (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0))) {
        return 29;
    }
    return days[month];
}

int daysFromStart(char *arriveDate) {
    int month = (arriveDate[0] - '0') * 10 + (arriveDate[1] - '0');
    int day = (arriveDate[3] - '0') * 10 + (arriveDate[4] - '0');
    int days = 0;
    for (int i = 1; i < month; i++) {
        days += daysInMonth(i, 2023);
    }
    days += day;
    return days;
}

int countDaysTogether(char *arriveAlice, char *leaveAlice, char *arriveBob,
                     char *leaveBob) {
    int arriveA = daysFromStart(arriveAlice);
    int leaveA = daysFromStart(leaveAlice);
    int arriveB = daysFromStart(arriveBob);
    int leaveB = daysFromStart(leaveBob);

    int start = (arriveA > arriveB) ? arriveA : arriveB;
    int end = (leaveA < leaveB) ? leaveA : leaveB;

    if (start > end) {
        return 0;
    }

    return end - start + 1;
}