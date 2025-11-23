#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestOddNumber(char* num) {
    int len = strlen(num);
    int i;
    for (i = len - 1; i >= 0; i--) {
        if ((num[i] - '0') % 2 == 1) {
            break;
        }
    }
    char* result = (char*)malloc((i + 2) * sizeof(char));
    strncpy(result, num, i + 1);
    result[i + 1] = '\0';
    return result;
}