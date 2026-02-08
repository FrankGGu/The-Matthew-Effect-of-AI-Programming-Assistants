#include <stdbool.h>

static bool is_leap(int y) {
    return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
}

char * dayOfTheWeek(int day, int month, int year) {
    static char *day_names[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

    int days_in_month[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    int total_days = 0;

    for (int y = 1971; y < year; y++) {
        total_days += 365;
        if (is_leap(y)) {
            total_days += 1;
        }
    }

    for (int m = 1; m < month; m++) {
        total_days += days_in_month[m];
        if (m == 2 && is_leap(year)) {
            total_days += 1;
        }
    }

    total_days += (day - 1);

    int day_index = (5 + total_days) % 7;

    return day_names[day_index];
}