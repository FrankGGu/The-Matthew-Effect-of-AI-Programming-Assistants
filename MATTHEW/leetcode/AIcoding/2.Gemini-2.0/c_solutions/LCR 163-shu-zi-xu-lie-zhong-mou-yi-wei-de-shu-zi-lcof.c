#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long getLength(int n) {
    long long len = 0, count = 9;
    int digits = 1;
    while (n > 0) {
        if (n >= count) {
            len += count * digits;
            n -= count;
            count *= 10;
            digits++;
        } else {
            len += (long long)n * digits;
            n = 0;
        }
    }
    return len;
}

int findNthDigit(int n) {
    int digits = 1;
    long long count = 9;
    while (n > (long long)digits * count) {
        n -= (int)(digits * count);
        digits++;
        count *= 10;
    }

    long long num = 1;
    for (int i = 1; i < digits; i++) {
        num *= 10;
    }

    num += (n - 1) / digits;
    int index = (n - 1) % digits;

    char str[12];
    sprintf(str, "%lld", num);

    return str[index] - '0';
}