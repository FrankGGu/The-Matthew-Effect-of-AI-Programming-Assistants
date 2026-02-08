#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int splitNum(int num) {
    char str[12];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int* digits = (int*)malloc(len * sizeof(int));
    for (int i = 0; i < len; i++) {
        digits[i] = str[i] - '0';
    }
    qsort(digits, len, sizeof(int), (int (*)(const void*, const void*))strcmp);
    int a = 0, b = 0;
    for (int i = 0; i < len; i++) {
        if (i % 2 == 0) {
            a = a * 10 + digits[i];
        } else {
            b = b * 10 + digits[i];
        }
    }
    free(digits);
    return a + b;
}