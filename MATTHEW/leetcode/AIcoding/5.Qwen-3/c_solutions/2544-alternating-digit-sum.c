#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int alternateDigitSum(int n) {
    char str[20];
    sprintf(str, "%d", n);
    int len = strlen(str);
    int sum = 0;
    for (int i = 0; i < len; i++) {
        int digit = str[i] - '0';
        if (i % 2 == 0) {
            sum += digit;
        } else {
            sum -= digit;
        }
    }
    return sum;
}