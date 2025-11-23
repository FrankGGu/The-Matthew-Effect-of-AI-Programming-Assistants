#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minLength(char * s){
    char stack[101] = {0};
    int top = -1;
    for (int i = 0; s[i] != '\0'; i++) {
        stack[++top] = s[i];
        if (top > 0) {
            if ((stack[top] == 'B' && stack[top - 1] == 'A') || (stack[top] == 'D' && stack[top - 1] == 'C')) {
                top -= 2;
            }
        }
    }
    return top + 1;
}