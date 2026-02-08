#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char* solveEquation(char* equation) {
    int x_coeff = 0;
    int constant = 0;
    int sign = 1; // +1 for left side, -1 for right side
    int current_sign = 1; // +1 for positive term, -1 for negative term
    int i = 0;
    int n = strlen(equation);

    while (i < n) {
        if (equation[i] == '=') {
            sign = -1;
            current_sign = 1;
            i++;
            continue;
        }

        if (equation[i] == '+') {
            current_sign = 1;
            i++;
            continue;
        }

        if (equation[i] == '-') {
            current_sign = -1;
            i++;
            continue;
        }

        int num = 0;
        int has_num = 0;
        while (i < n && equation[i] >= '0' && equation[i] <= '9') {
            num = num * 10 + (equation[i] - '0');
            has_num = 1;
            i++;
        }

        if (i < n && equation[i] == 'x') {
            if (!has_num) {
                num = 1;
            }
            x_coeff += sign * current_sign * num;
            i++;
        } else {
            constant += sign * current_sign * num;
        }
    }

    if (x_coeff == 0) {
        if (constant == 0) {
            return strdup("Infinite solutions");
        } else {
            return strdup("No solution");
        }
    } else {
        int result = -constant / x_coeff;
        char* ans = (char*)malloc(sizeof(char) * 20); // Max length for "x=-2147483648" is 13 + null
        sprintf(ans, "x=%d", result);
        return ans;
    }
}