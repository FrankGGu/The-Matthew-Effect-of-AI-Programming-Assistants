#include <limits.h>

int myAtoi(char * s) {
    int i = 0;
    long result = 0;
    int sign = 1;

    // 1. Skip leading whitespace
    while (s[i] == ' ') {
        i++;
    }

    // 2. Check for sign
    if (s[i] == '-') {
        sign = -1;
        i++;
    } else if (s[i] == '+') {
        i++;
    }

    // 3. Read digits and handle overflow
    while (s[i] >= '0' && s[i] <= '9') {
        int digit = s[i] - '0';
        result = result * 10 + digit;

        // Check for overflow
        if (sign == 1 && result > INT_MAX) {
            return INT_MAX;
        }
        if (sign == -1 && result > (long)INT_MAX + 1) {
            return INT_MIN;
        }
        i++;
    }

    // 4. Apply sign and return
    return (int)(sign * result);
}