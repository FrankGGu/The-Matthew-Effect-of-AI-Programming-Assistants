#include <stdio.h>
#include <stdlib.h>

int daysBetweenDates(char* date1, char* date2) {
    int year1 = atoi(date1);
    int month1 = atoi(date1 + 5);
    int day1 = atoi(date1 + 8);

    int year2 = atoi(date2);
    int month2 = atoi(date2 + 5);
    int day2 = atoi(date2 + 8);

    int days1 = 0, days2 = 0;

    int leap(int y) {
        return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
    }

    int daysInMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    for (int y = 1; y < year1; y++) {
        days1 += leap(y) ? 366 : 365;
    }

    for (int m = 1; m < month1; m++) {
        days1 += daysInMonth[m - 1];
        if (m == 2 && leap(year1)) days1++;
    }

    days1 += day1;

    for (int y = 1; y < year2; y++) {
        days2 += leap(y) ? 366 : 365;
    }

    for (int m = 1; m < month2; m++) {
        days2 += daysInMonth[m - 1];
        if (m == 2 && leap(year2)) days2++;
    }

    days2 += day2;

    return abs(days1 - days2);
}