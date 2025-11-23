#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * makeGood(char * s){
    int len = strlen(s);
    char *stack = (char *)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && ((s[i] - stack[top] == 32) || (stack[top] - s[i] == 32))) {
            top--;
        } else {
            stack[++top] = s[i];
        }
    }

    stack[top + 1] = '\0';
    return stack;
}