#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <ctype.h>

int myAtoi(char *str) {
    int sign = 1;
    long result = 0;
    int i = 0;

    while (str[i] == ' ') {
        i++;
    }

    if (str[i] == '-') {
        sign = -1;
        i++;
    } else if (str[i] == '+') {
        i++;
    }

    while (str[i] >= '0' && str[i] <= '9') {
        result = result * 10 + (str[i] - '0');
        if (result > INT_MAX) {
            return (sign == -1) ? INT_MIN : INT_MAX;
        }
        i++;
    }

    return (int)(sign * result);
}