#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char * reformatNumber(char * s){
    int len_s = strlen(s);
    char *digits = (char *)malloc(sizeof(char) * (len_s + 1));
    int digitCount = 0;

    for (int i = 0; i < len_s; i++) {
        if (isdigit(s[i])) {
            digits[digitCount++] = s[i];
        }
    }
    digits[digitCount] = '\0';

    char *res = (char *)malloc(sizeof(char) * (len_s * 2 + 1));
    int resIndex = 0;
    int digitsIndex = 0;

    while (digitCount - digitsIndex > 4) {
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = '-';
    }

    int remainingDigits = digitCount - digitsIndex;
    if (remainingDigits == 4) {
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = '-';
        res[resIndex++] = digits[digitsIndex++];
        res[resIndex++] = digits[digitsIndex++];
    } else {
        while (digitsIndex < digitCount) {
            res[resIndex++] = digits[digitsIndex++];
        }
    }

    res[resIndex] = '\0';

    free(digits);

    return res;
}