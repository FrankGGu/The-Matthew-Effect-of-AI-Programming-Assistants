#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int divide(int dividend, int divisor) {
    if (divisor == 1) return dividend;
    if (divisor == -1) {
        if (dividend > INT_MIN) return -dividend;
        else return INT_MAX;
    }

    int sign = ((dividend < 0) ^ (divisor < 0)) ? -1 : 1;

    long long a = labs(dividend);
    long long b = labs(divisor);

    int result = 0;

    while (a >= b) {
        long long temp = b;
        int i = 0;
        while (a >= (temp << 1)) {
            temp <<= 1;
            i++;
        }
        result += (1 << i);
        a -= temp;
    }

    return sign * result;
}