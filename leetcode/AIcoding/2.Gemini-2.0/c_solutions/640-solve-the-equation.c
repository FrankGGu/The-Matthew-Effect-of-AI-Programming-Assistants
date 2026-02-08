#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* solveEquation(char* equation) {
    int x_coeff = 0, const_term = 0;
    int sign = 1;
    int num = 0;
    int i = 0;
    int len = strlen(equation);
    int left = 1;

    while (i < len) {
        if (equation[i] == '+') {
            const_term -= sign * num * left;
            num = 0;
            sign = 1;
            i++;
        } else if (equation[i] == '-') {
            const_term -= sign * num * left;
            num = 0;
            sign = -1;
            i++;
        } else if (equation[i] == '=') {
            const_term -= sign * num * left;
            num = 0;
            sign = 1;
            left = -1;
            i++;
        } else if (equation[i] == 'x') {
            if (num == 0) {
                x_coeff += sign * left;
            } else {
                x_coeff += sign * num * left;
            }
            num = 0;
            i++;
        } else {
            num = num * 10 + (equation[i] - '0');
            i++;
        }
    }
    const_term -= sign * num * left;

    if (x_coeff == 0) {
        if (const_term == 0) {
            return "Infinite solutions";
        } else {
            return "No solution";
        }
    } else {
        int ans = -const_term / x_coeff;
        char* result = (char*)malloc(20 * sizeof(char));
        sprintf(result, "x=%d", ans);
        return result;
    }
}