#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}

int splitNum(int num) {
    char numStr[11];
    sprintf(numStr, "%d", num);
    int len = strlen(numStr);

    qsort(numStr, len, sizeof(char), cmpfunc);

    char num1Str[6] = "";
    char num2Str[6] = "";
    int num1Idx = 0;
    int num2Idx = 0;

    for (int i = 0; i < len; i++) {
        if (i % 2 == 0) {
            num1Str[num1Idx++] = numStr[i];
        } else {
            num2Str[num2Idx++] = numStr[i];
        }
    }
    num1Str[num1Idx] = '\0';
    num2Str[num2Idx] = '\0';

    return atoi(num1Str) + atoi(num2Str);
}