#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int myAtoi(char * s){
    int sign = 1;
    int result = 0;
    int i = 0;

    while (s[i] == ' ') {
        i++;
    }

    if (s[i] == '+' || s[i] == '-') {
        sign = (s[i] == '-') ? -1 : 1;
        i++;
    }

    while (isdigit(s[i])) {
        int digit = s[i] - '0';

        if (result > INT_MAX / 10 || (result == INT_MAX / 10 && digit > INT_MAX % 10)) {
            return (sign == 1) ? INT_MAX : INT_MIN;
        }

        result = result * 10 + digit;
        i++;
    }

    return sign * result;
}