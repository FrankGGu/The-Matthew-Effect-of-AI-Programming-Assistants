#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int findNthDigit(int n) {
    int digits = 1;
    long long count = 9;
    while (n > count) {
        n -= count;
        digits++;
        count *= 10;
    }
    long long number = pow(10, digits - 1) + (n - 1) / digits;
    int index = (n - 1) % digits;
    return to_string(number)[index] - '0';
}