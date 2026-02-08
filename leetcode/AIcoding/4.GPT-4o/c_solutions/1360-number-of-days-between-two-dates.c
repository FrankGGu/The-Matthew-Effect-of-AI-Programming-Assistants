int DaysBetweenDates(char * date1, char * date2) {
    int day1, month1, year1, day2, month2, year2;
    sscanf(date1, "%d-%d-%d", &year1, &month1, &day1);
    sscanf(date2, "%d-%d-%d", &year2, &month2, &day2);

    int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    int isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    int countDays(int year, int month, int day) {
        int days = day;
        for (int i = 1; i < month; i++) {
            days += daysInMonth[i];
        }
        for (int i = 1; i < year; i++) {
            days += 365 + isLeapYear(i);
        }
        if (month > 2 && isLeapYear(year)) {
            days++;
        }
        return days;
    }

    int days1 = countDays(year1, month1, day1);
    int days2 = countDays(year2, month2, day2);
    return abs(days1 - days2);
}