char* reformatDate(char* date) {
    char* months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int day, month, year;
    sscanf(date, "%d %s %d", &day, months[month], &year);

    for (month = 0; month < 12; month++) {
        if (strcmp(months[month], date + 5) == 0) break;
    }

    char* result = (char*)malloc(11 * sizeof(char));
    sprintf(result, "%04d-%02d-%02d", year, month + 1, day);
    return result;
}