#include <stdlib.h>
#include <string.h>
#include <stdio.h>

long long gcd(long long a, long long b) {
    a = llabs(a);
    b = llabs(b);
    while (b) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

char * fractionAddition(char * expression){
    long long current_num = 0;
    long long current_den = 1;

    int i = 0;
    int len = strlen(expression);

    while (i < len) {
        int sign = 1;
        if (expression[i] == '-') {
            sign = -1;
            i++;
        } else if (expression[i] == '+') {
            i++;
        }

        long long num = 0;
        while (i < len && expression[i] >= '0' && expression[i] <= '9') {
            num = num * 10 + (expression[i] - '0');
            i++;
        }

        i++; // Skip '/'

        long long den = 0;
        while (i < len && expression[i] >= '0' && expression[i] <= '9') {
            den = den * 10 + (expression[i] - '0');
            i++;
        }

        current_num = current_num * den + sign * num * current_den;
        current_den = current_den * den;

        long long common_divisor = gcd(current_num, current_den);
        current_num /= common_divisor;
        current_den /= common_divisor;
    }

    char *result = (char *)malloc(45 * sizeof(char));
    sprintf(result, "%lld/%lld", current_num, current_den);

    return result;
}