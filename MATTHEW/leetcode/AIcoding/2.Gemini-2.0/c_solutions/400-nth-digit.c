#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findNthDigit(int n) {
    long long digits = 1;
    long long count = 9;
    long long start = 1;

    while (n > digits * count) {
        n -= digits * count;
        digits++;
        count *= 10;
        start *= 10;
    }

    long long num = start + (n - 1) / digits;
    int index = (n - 1) % digits;

    char str[12];
    sprintf(str, "%lld", num);

    return str[index] - '0';
}