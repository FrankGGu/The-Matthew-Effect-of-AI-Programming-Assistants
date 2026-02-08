#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int calculate(char* s) {
    int n = 0;
    int num = 0;
    int sign = '+';
    int stack[1000];
    int top = -1;

    while (*s) {
        if (isdigit(*s)) {
            num = num * 10 + (*s - '0');
        } else if (*s != ' ') {
            if (sign == '+') {
                stack[++top] = num;
            } else if (sign == '-') {
                stack[++top] = -num;
            } else if (sign == '*') {
                stack[top] = stack[top] * num;
            } else if (sign == '/') {
                stack[top] = stack[top] / num;
            }
            sign = *s;
            num = 0;
        }
        s++;
    }

    if (sign == '+') {
        stack[++top] = num;
    } else if (sign == '-') {
        stack[++top] = -num;
    } else if (sign == '*') {
        stack[top] = stack[top] * num;
    } else if (sign == '/') {
        stack[top] = stack[top] / num;
    }

    while (top >= 0) {
        n += stack[top--];
    }

    return n;
}