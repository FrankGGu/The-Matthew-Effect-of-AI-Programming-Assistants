#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* dayOfTheWeek(int day, int month, int year) {
    const char* days[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
    int daysInMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int totalDays = 0;
    int leapYear = 0;

    for (int y = 1970; y < year; y++) {
        totalDays += 365;
        if ((y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)) {
            totalDays++;
        }
    }

    for (int m = 1; m < month; m++) {
        totalDays += daysInMonth[m - 1];
        if (m == 2 && ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))) {
            totalDays++;
        }
    }

    totalDays += day - 1;

    return (char*)days[totalDays % 7];
}