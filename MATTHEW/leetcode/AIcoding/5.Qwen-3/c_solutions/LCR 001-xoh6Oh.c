#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int divide(int dividend, int divisor) {
    if (dividend == INT_MIN && divisor == -1) {
        return INT_MAX;
    }
    int sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1;
    long a = labs(dividend);
    long b = labs(divisor);
    long result = 0;
    while (a >= b) {
        long temp = b;
        long i = 1;
        while (temp <= a) {
            temp <<= 1;
            i <<= 1;
        }
        a -= temp >> 1;
        result += i >> 1;
    }
    return sign == 1 ? result : -result;
}