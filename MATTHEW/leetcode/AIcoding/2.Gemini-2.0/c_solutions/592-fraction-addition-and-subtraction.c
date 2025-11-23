#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    return b == 0 ? a : gcd(b, a % b);
}

char* fractionAddition(char* expression) {
    int num = 0, den = 1;
    int sign = 1;
    int i = 0;
    while (i < strlen(expression)) {
        if (expression[i] == '+' || expression[i] == '-') {
            if (i > 0) {
                sign = expression[i] == '+' ? 1 : -1;
            } else {
                sign = expression[i] == '+' ? 1 : -1;
            }
            i++;
        }
        int num1 = 0;
        while (i < strlen(expression) && expression[i] >= '0' && expression[i] <= '9') {
            num1 = num1 * 10 + (expression[i] - '0');
            i++;
        }
        i++; 
        int den1 = 0;
        while (i < strlen(expression) && expression[i] >= '0' && expression[i] <= '9') {
            den1 = den1 * 10 + (expression[i] - '0');
            i++;
        }

        int new_num = num * den1 + sign * num1 * den;
        int new_den = den * den1;

        int common = gcd(abs(new_num), abs(new_den));
        num = new_num / common;
        den = new_den / common;
    }

    char* result = (char*)malloc(100 * sizeof(char));
    sprintf(result, "%d/%d", num, den);
    return result;
}