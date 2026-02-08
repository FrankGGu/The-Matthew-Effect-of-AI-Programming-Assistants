int daysBetweenDates(char* date1, char* date2) {
    int days1 = calculateDays(date1);
    int days2 = calculateDays(date2);
    return abs(days1 - days2);
}

int calculateDays(char* date) {
    int year, month, day;
    sscanf(date, "%d-%d-%d", &year, &month, &day);

    int total = 0;
    for (int y = 1971; y < year; y++) {
        total += isLeapYear(y) ? 366 : 365;
    }

    int months[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if (isLeapYear(year)) months[1] = 29;

    for (int m = 0; m < month - 1; m++) {
        total += months[m];
    }

    total += day;
    return total;
}

int isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}