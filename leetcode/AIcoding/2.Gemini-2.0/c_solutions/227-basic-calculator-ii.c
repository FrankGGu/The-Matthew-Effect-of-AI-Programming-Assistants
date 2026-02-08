#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculate(char * s){
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }

    int stack[len];
    int top = -1;
    int num = 0;
    char op = '+';

    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + (s[i] - '0');
        }
        if (!isdigit(s[i]) && s[i] != ' ' || i == len - 1) {
            if (op == '+') {
                stack[++top] = num;
            } else if (op == '-') {
                stack[++top] = -num;
            } else if (op == '*') {
                stack[top] = stack[top] * num;
            } else if (op == '/') {
                stack[top] = stack[top] / num;
            }
            op = s[i];
            num = 0;
        }
    }

    int res = 0;
    for (int i = 0; i <= top; i++) {
        res += stack[i];
    }

    return res;
}