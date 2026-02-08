#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int calculate(char* s) {
    int stack[1000];
    int top = -1;
    int num = 0;
    int sign = 1;
    int result = 0;

    for (int i = 0; s[i]; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + (s[i] - '0');
        } else {
            result += sign * num;
            num = 0;

            if (s[i] == '+') {
                sign = 1;
            } else if (s[i] == '-') {
                sign = -1;
            } else if (s[i] == '(') {
                stack[++top] = sign;
                sign = 1;
            } else if (s[i] == ')') {
                sign = stack[top--];
            }
        }
    }

    result += sign * num;
    return result;
}