#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char * s){
    int len = strlen(s);
    char stack[len + 1];
    int top = -1;

    for (int i = 0; i < len; i++) {
        stack[++top] = s[i];
        if (top >= 2 && stack[top] == 'c' && stack[top - 1] == 'b' && stack[top - 2] == 'a') {
            top -= 3;
        }
    }

    return top == -1;
}