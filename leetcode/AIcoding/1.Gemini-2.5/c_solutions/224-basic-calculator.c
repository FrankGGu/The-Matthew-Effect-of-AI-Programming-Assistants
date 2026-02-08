#include <string.h>
#include <stdlib.h>

#define MAX_STACK_SIZE 300005

int calculate(char * s){
    long long stack[MAX_STACK_SIZE];
    int top = -1; 

    long long result = 0;
    long long num = 0;
    int sign = 1; 

    int i = 0;
    int len = strlen(s);

    while (i < len) {
        char c = s[i];

        if (c >= '0' && c <= '9') {
            num = num * 10 + (c - '0');
        } else if (c == '+') {
            result += sign * num;
            num = 0;
            sign = 1;
        } else if (c == '-') {
            result += sign * num;
            num = 0;
            sign = -1;
        } else if (c == '(') {
            stack[++top] = result; 
            stack[++top] = sign;   
            result = 0;            
            sign = 1;              
        } else if (c == ')') {
            result += sign * num; 
            num = 0; 

            sign = stack[top--];
            long long prev_result = stack[top--];

            result = prev_result + result * sign;
        }
        i++;
    }

    if (num != 0) {
        result += sign * num;
    }

    return (int)result;
}