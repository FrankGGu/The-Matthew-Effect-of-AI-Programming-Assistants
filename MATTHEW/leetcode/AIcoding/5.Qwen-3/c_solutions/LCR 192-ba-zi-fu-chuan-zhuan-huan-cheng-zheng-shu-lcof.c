#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <limits.h>

int myAtoi(char *s) {
    int sign = 1;
    long result = 0;
    int i = 0;

    while (s[i] == ' ') {
        i++;
    }

    if (s[i] == '-') {
        sign = -1;
        i++;
    } else if (s[i] == '+') {
        i++;
    }

    while (s[i] >= '0' && s[i] <= '9') {
        result = result * 10 + (s[i] - '0');
        if (result > INT_MAX) {
            return (sign == -1) ? INT_MIN : INT_MAX;
        }
        i++;
    }

    return (int)(sign * result);
}