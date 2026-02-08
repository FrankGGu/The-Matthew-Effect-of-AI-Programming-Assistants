int dayOfYear(char * date) {
    int year, month, day;
    sscanf(date, "%d-%d-%d", &year, &month, &day);

    int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int totalDays = day;

    for (int i = 1; i < month; i++) {
        totalDays += daysInMonth[i];
    }

    if (month > 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
        totalDays++;
    }

    return totalDays;
}