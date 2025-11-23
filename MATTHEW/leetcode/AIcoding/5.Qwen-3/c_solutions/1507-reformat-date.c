#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reformatDate(char* date) {
    char* day = (char*)malloc(3 * sizeof(char));
    char* month = (char*)malloc(4 * sizeof(char));
    char* year = (char*)malloc(5 * sizeof(char));
    char* result = (char*)malloc(11 * sizeof(char));

    sscanf(date, "%s %s %s", day, month, year);

    int dayInt = atoi(day);
    sprintf(day, "%d", dayInt);

    if (strlen(month) == 3) {
        if (strcmp(month, "Jan") == 0) strcpy(month, "01");
        else if (strcmp(month, "Feb") == 0) strcpy(month, "02");
        else if (strcmp(month, "Mar") == 0) strcpy(month, "03");
        else if (strcmp(month, "Apr") == 0) strcpy(month, "04");
        else if (strcmp(month, "May") == 0) strcpy(month, "05");
        else if (strcmp(month, "Jun") == 0) strcpy(month, "06");
        else if (strcmp(month, "Jul") == 0) strcpy(month, "07");
        else if (strcmp(month, "Aug") == 0) strcpy(month, "08");
        else if (strcmp(month, "Sep") == 0) strcpy(month, "09");
        else if (strcmp(month, "Oct") == 0) strcpy(month, "10");
        else if (strcmp(month, "Nov") == 0) strcpy(month, "11");
        else if (strcmp(month, "Dec") == 0) strcpy(month, "12");
    }

    sprintf(result, "%s-%s-%s", year, month, day);
    return result;
}