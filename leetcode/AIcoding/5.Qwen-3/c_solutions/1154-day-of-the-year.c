#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dayOfYear(char *date) {
    int daysInMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int year, month, day;
    sscanf(date, "%d-%d-%d", &year, &month, &day);

    if (month > 1 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
        daysInMonth[1] = 29;
    }

    int dayOfYear = 0;
    for (int i = 0; i < month - 1; i++) {
        dayOfYear += daysInMonth[i];
    }
    dayOfYear += day;

    return dayOfYear;
}