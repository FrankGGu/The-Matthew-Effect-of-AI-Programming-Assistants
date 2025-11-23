#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int repeatedStringMatch(char *a, char *b) {
    int count = 1;
    char *temp = (char *)malloc(strlen(a) * sizeof(char) + 1);
    strcpy(temp, a);

    while (strlen(temp) < strlen(b)) {
        temp = (char *)realloc(temp, (strlen(temp) + strlen(a) + 1) * sizeof(char));
        strcat(temp, a);
        count++;
    }

    if (strstr(temp, b) != NULL) {
        free(temp);
        return count;
    }

    temp = (char *)realloc(temp, (strlen(temp) + strlen(a) + 1) * sizeof(char));
    strcat(temp, a);
    count++;

    if (strstr(temp, b) != NULL) {
        free(temp);
        return count;
    }

    free(temp);
    return -1;
}