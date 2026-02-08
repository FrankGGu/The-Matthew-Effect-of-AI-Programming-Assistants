#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* orderlyQueue(char* s, int k) {
    if (k == 0) return s;
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, s);
    for (int i = 1; i < len; i++) {
        char* temp = (char*)malloc((len + 1) * sizeof(char));
        strncpy(temp, s + i, len - i);
        strncpy(temp + (len - i), s, i);
        temp[len] = '\0';
        if (strcmp(temp, result) < 0) {
            strcpy(result, temp);
        }
        free(temp);
    }
    return result;
}