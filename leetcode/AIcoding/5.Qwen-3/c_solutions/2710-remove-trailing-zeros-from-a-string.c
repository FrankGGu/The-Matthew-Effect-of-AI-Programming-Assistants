#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeTrailingZeros(char* num) {
    int len = strlen(num);
    int i = len - 1;
    while (i >= 0 && num[i] == '0') {
        i--;
    }
    char* result = (char*)malloc((i + 2) * sizeof(char));
    strncpy(result, num, i + 1);
    result[i + 1] = '\0';
    return result;
}