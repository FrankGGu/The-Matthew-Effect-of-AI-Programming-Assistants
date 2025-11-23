#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int daysInMonth(int year, int month) {
    int days[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (month == 2 && isLeapYear(year)) {
        return 29;
    }
    return days[month];
}

int daysFrom1971(int year, int month, int day) {
    int days = 0;
    for (int y = 1971; y < year; y++) {
        days += isLeapYear(y) ? 366 : 365;
    }
    for (int m = 1; m < month; m++) {
        days += daysInMonth(year, m);
    }
    days += day;
    return days;
}

int daysBetweenDates(char * date1, char * date2){
    int year1, month1, day1;
    int year2, month2, day2;
    sscanf(date1, "%d-%d-%d", &year1, &month1, &day1);
    sscanf(date2, "%d-%d-%d", &year2, &month2, &day2);

    int days1 = daysFrom1971(year1, month1, day1);
    int days2 = daysFrom1971(year2, month2, day2);

    return abs(days2 - days1);
}