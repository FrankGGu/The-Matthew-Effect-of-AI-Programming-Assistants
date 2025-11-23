#include <stdlib.h>
#include <stdio.h>

static int is_leap(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

static int days_in_month[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

static int count_days_from_epoch(int year, int month, int day) {
    int total_days = 0;

    for (int y = 1; y < year; ++y) {
        total_days += is_leap(y) ? 366 : 365;
    }

    for (int m = 1; m < month; ++m) {
        total_days += days_in_month[m];
        if (m == 2 && is_leap(year)) {
            total_days += 1;
        }
    }

    total_days += day;

    return total_days;
}

int daysBetweenDates(char *date1, char *date2) {
    int year1, month1, day1;
    int year2, month2, day2;

    sscanf(date1, "%d-%d-%d", &year1, &month1, &day1);
    sscanf(date2, "%d-%d-%d", &year2, &month2, &day2);

    int total_days1 = count_days_from_epoch(year1, month1, day1);
    int total_days2 = count_days_from_epoch(year2, month2, day2);

    return abs(total_days1 - total_days2);
}