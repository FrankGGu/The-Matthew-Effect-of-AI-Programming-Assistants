#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* convertDateToBinary(char* date) {
    char* result = (char*)malloc(20 * sizeof(char));
    int day, month, year;
    sscanf(date, "%d-%d-%d", &day, &month, &year);

    char dayStr[10], monthStr[10], yearStr[10];
    sprintf(dayStr, "%d", day);
    sprintf(monthStr, "%d", month);
    sprintf(yearStr, "%d", year);

    char* binDay = (char*)malloc(20 * sizeof(char));
    char* binMonth = (char*)malloc(20 * sizeof(char));
    char* binYear = (char*)malloc(20 * sizeof(char));

    int i = 0;
    while (day > 0) {
        binDay[i++] = (day % 2) + '0';
        day /= 2;
    }
    binDay[i] = '\0';
    for (int j = 0; j < i / 2; j++) {
        char temp = binDay[j];
        binDay[j] = binDay[i - 1 - j];
        binDay[i - 1 - j] = temp;
    }

    i = 0;
    while (month > 0) {
        binMonth[i++] = (month % 2) + '0';
        month /= 2;
    }
    binMonth[i] = '\0';
    for (int j = 0; j < i / 2; j++) {
        char temp = binMonth[j];
        binMonth[j] = binMonth[i - 1 - j];
        binMonth[i - 1 - j] = temp;
    }

    i = 0;
    while (year > 0) {
        binYear[i++] = (year % 2) + '0';
        year /= 2;
    }
    binYear[i] = '\0';
    for (int j = 0; j < i / 2; j++) {
        char temp = binYear[j];
        binYear[j] = binYear[i - 1 - j];
        binYear[i - 1 - j] = temp;
    }

    sprintf(result, "%s.%s.%s", binDay, binMonth, binYear);

    free(binDay);
    free(binMonth);
    free(binYear);

    return result;
}