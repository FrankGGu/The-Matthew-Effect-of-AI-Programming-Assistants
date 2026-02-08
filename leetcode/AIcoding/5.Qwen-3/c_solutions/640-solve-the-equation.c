#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* solveEquation(char* equation) {
    int left = 0, right = 0;
    char* token;
    char* expr = strdup(equation);
    char* ptr = expr;
    int sign = 1;

    while (*ptr != '=') {
        if (*ptr == '+') {
            sign = 1;
            ptr++;
        } else if (*ptr == '-') {
            sign = -1;
            ptr++;
        }
        if (isdigit(*ptr) || (*ptr == 'x' && !isalpha(*(ptr + 1)))) {
            if (*ptr == 'x') {
                left += sign * 1;
                ptr++;
            } else {
                token = strtok(ptr, "+-");
                left += sign * atoi(token);
                ptr += strlen(token);
            }
        } else if (*ptr == 'x') {
            left += sign * 1;
            ptr++;
        } else {
            ptr++;
        }
    }
    ptr++;

    sign = 1;
    while (*ptr) {
        if (*ptr == '+') {
            sign = 1;
            ptr++;
        } else if (*ptr == '-') {
            sign = -1;
            ptr++;
        }
        if (isdigit(*ptr) || (*ptr == 'x' && !isalpha(*(ptr + 1)))) {
            if (*ptr == 'x') {
                right += sign * 1;
                ptr++;
            } else {
                token = strtok(ptr, "+-");
                right += sign * atoi(token);
                ptr += strlen(token);
            }
        } else if (*ptr == 'x') {
            right += sign * 1;
            ptr++;
        } else {
            ptr++;
        }
    }

    free(expr);

    if (left == right) return "Infinite solutions";
    if (left == 0) return "No solution";
    int x = left - right;
    int val = -right;
    char* result = (char*)malloc(20 * sizeof(char));
    sprintf(result, "%d", val / x);
    return result;
}