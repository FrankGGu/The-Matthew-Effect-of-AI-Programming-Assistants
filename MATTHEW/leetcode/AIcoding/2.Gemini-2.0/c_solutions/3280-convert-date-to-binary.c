#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * convertDate(char * date) {
    char *month_str[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int day, month, year;
    char day_str[3], month_s[4], year_str[5];
    sscanf(date, "%s %s %s", day_str, month_s, year_str);

    day = atoi(day_str);
    int i = 0;
    while (day_str[i] >= '0' && day_str[i] <= '9') {
        i++;
    }
    day_str[i] = '\0';
    day = atoi(day_str);

    for (month = 0; month < 12; month++) {
        if (strcmp(month_s, month_str[month]) == 0) {
            month++;
            break;
        }
    }

    year = atoi(year_str);

    int binary_date = (year << 9) | (month << 5) | day;

    char *result = (char *)malloc(17 * sizeof(char));
    sprintf(result, "%d", binary_date);
    return result;
}