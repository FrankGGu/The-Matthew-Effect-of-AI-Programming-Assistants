#include <stdio.h>
#include <limits.h> // For INT_MAX and INT_MIN
#include <ctype.h>  // For isspace and isdigit

int myAtoi(char * s) {
    long long result = 0;
    int sign = 1;
    int i = 0;

    // 1. Read and ignore any leading whitespace
    while (s[i] == ' ') {
        i++;
    }

    // 2. Check if the next character is '-' or '+'
    if (s[i] == '-') {
        sign = -1;
        i++;
    } else if (s[i] == '+') {
        i++;
    }

    // 3. Read in next the characters until the next non-digit character or the end of the input is reached.
    // 4. Convert these digits into an integer.
    while (s[i] >= '0' && s[i] <= '9') {
        int digit = s[i] - '0';

        // 6. Handle overflow/underflow before adding the current digit
        // If result * 10 + digit would exceed INT_MAX or fall below INT_MIN
        if (sign == 1) {
            if (result > INT_MAX / 10 || (result == INT_MAX / 10 && digit > 7)) {
                return INT_MAX;
            }
        } else { // sign == -1
            // For negative numbers, INT_MIN is -2147483648. Its absolute value is 2147483648.
            // INT_MAX is 2147483647.
            // So, if the absolute value of result exceeds INT_MAX, and it's negative,
            // it could potentially be INT_MIN.
            // If result (absolute value) exceeds (long long)INT_MAX + 1, then it's definitely underflow.
            // If result (absolute value) equals (long long)INT_MAX + 1, then it's INT_MIN.
            if (result > INT_MAX / 10 || (result == INT_MAX / 10 && digit > 8)) {
                return INT_MIN;
            }
        }

        result = result * 10 + digit;
        i++;
    }

    // 5. Apply the sign
    return (int)(result * sign);
}