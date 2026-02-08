#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char* reformatDate(char* date) {
    char* result = (char*)malloc(sizeof(char) * 11);
    if (result == NULL) {
        return NULL;
    }

    int day_val;
    int month_val;
    int year_val;

    char day_str[3];
    int i = 0;
    while (date[i] >= '0' && date[i] <= '9') {
        day_str[i] = date[i];
        i++;
    }
    day_str[i] = '\0';
    day_val = atoi(day_str);

    while (date[i] != ' ') {
        i++;
    }
    i++;

    char month_abbr[4];
    strncpy(month_abbr, date + i, 3);
    month_abbr[3] = '\0';
    i += 3;
    i++;

    year_val = atoi(date + i);

    if (strcmp(month_abbr, "Jan") == 0) month_val = 1;
    else if (strcmp(month_abbr, "Feb") == 0) month_val = 2;
    else if (strcmp(month_abbr, "Mar") == 0) month_val = 3;
    else if (strcmp(month_abbr, "Apr") == 0) month_val = 4;
    else if (strcmp(month_abbr, "May") == 0) month_val = 5;
    else if (strcmp(month_abbr, "Jun") == 0) month_val = 6;
    else if (strcmp(month_abbr, "Jul") == 0) month_val = 7;
    else if (strcmp(month_abbr, "Aug") == 0) month_val = 8;
    else if (strcmp(month_abbr, "Sep") == 0) month_val = 9;
    else if (strcmp(month_abbr, "Oct") == 0) month_val = 10;
    else if (strcmp(month_abbr, "Nov") == 0) month_val = 11;
    else if (strcmp(month_abbr, "Dec") == 0) month_val = 12;
    else month_val = 0;

    sprintf(result, "%04d-%02d-%02d", year_val, month_val, day_val);

    return result;
}