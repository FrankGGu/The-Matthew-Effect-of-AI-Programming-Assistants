#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculate(char * s){
    int i = 0;
    int sign = 1;
    int res = 0;
    int stack[1000];
    int top = -1;

    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            int num = 0;
            while (s[i] >= '0' && s[i] <= '9') {
                num = num * 10 + (s[i] - '0');
                i++;
            }
            res += sign * num;
            i--;
        } else if (s[i] == '+') {
            sign = 1;
        } else if (s[i] == '-') {
            sign = -1;
        } else if (s[i] == '(') {
            stack[++top] = res;
            stack[++top] = sign;
            res = 0;
            sign = 1;
        } else if (s[i] == ')') {
            res = stack[top--] * res + stack[top--];
        }
        i++;
    }
    return res;
}