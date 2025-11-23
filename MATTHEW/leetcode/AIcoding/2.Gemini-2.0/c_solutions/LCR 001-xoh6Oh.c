#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int divide(int dividend, int divisor) {
    if (divisor == 0) {
        return (dividend > 0) ? INT_MAX : INT_MIN;
    }
    if (dividend == INT_MIN && divisor == -1) {
        return INT_MAX;
    }

    long long dvd = (long long)dividend;
    long long dvs = (long long)divisor;

    int sign = 1;
    if (dvd < 0) {
        sign = -sign;
        dvd = -dvd;
    }
    if (dvs < 0) {
        sign = -sign;
        dvs = -dvs;
    }

    long long quotient = 0;
    while (dvd >= dvs) {
        long long temp = dvs;
        long long multiple = 1;
        while (dvd >= (temp << 1) && (temp << 1) > 0) {
            temp <<= 1;
            multiple <<= 1;
        }
        dvd -= temp;
        quotient += multiple;
    }

    if (sign == 1) {
        return (quotient > INT_MAX) ? INT_MAX : (int)quotient;
    } else {
        return (int)-quotient;
    }
}