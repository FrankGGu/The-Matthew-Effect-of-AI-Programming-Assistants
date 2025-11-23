#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reformatDate(char * date){
    char *months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    char *day = (char*)malloc(3 * sizeof(char));
    char *month = (char*)malloc(4 * sizeof(char));
    char *year = (char*)malloc(5 * sizeof(char));
    int i = 0, j = 0, k = 0;
    while (date[i] >= '0' && date[i] <= '9') {
        day[j++] = date[i++];
    }
    day[j] = '\0';
    i += 4;
    j = 0;
    while (date[i] != ' ') {
        month[j++] = date[i++];
    }
    month[j] = '\0';
    i++;
    j = 0;
    while (date[i] != '\0') {
        year[j++] = date[i++];
    }
    year[j] = '\0';

    int month_num = 0;
    for (int m = 0; m < 12; m++) {
        if (strcmp(month, months[m]) == 0) {
            month_num = m + 1;
            break;
        }
    }

    char *result = (char*)malloc(11 * sizeof(char));
    sprintf(result, "%s-%02d-%02d", year, month_num, atoi(day));

    free(day);
    free(month);
    free(year);

    return result;
}