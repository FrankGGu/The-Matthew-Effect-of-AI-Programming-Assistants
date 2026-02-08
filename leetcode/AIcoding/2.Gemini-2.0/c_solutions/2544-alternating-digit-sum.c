#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int alternateDigitSum(int n) {
    int sum = 0;
    char str[11];
    sprintf(str, "%d", n);
    int sign = 1;
    for (int i = 0; str[i] != '\0'; i++) {
        sum += sign * (str[i] - '0');
        sign *= -1;
    }
    return sum;
}