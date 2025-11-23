#include <limits.h>
#include <stdbool.h>

int divide(int dividend, int divisor) {
    if (dividend == INT_MIN && divisor == -1) {
        return INT_MAX;
    }

    bool is_negative = (dividend < 0) ^ (divisor < 0);

    long long dvd = dividend;
    long long dvs = divisor;

    if (dvd < 0) {
        dvd = -dvd;
    }
    if (dvs < 0) {
        dvs = -dvs;
    }

    long long result = 0;

    while (dvd >= dvs) {
        long long temp_dvs = dvs;
        long long multiple = 1;
        while (dvd >= (temp_dvs << 1)) {
            temp_dvs <<= 1;
            multiple <<= 1;
        }
        dvd -= temp_dvs;
        result += multiple;
    }

    if (is_negative) {
        return -result;
    } else {
        return result;
    }
}