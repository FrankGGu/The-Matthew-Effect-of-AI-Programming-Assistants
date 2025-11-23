#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeDuplicates(char * s){
    int len = strlen(s);
    char *stack = (char*)malloc(sizeof(char) * (len + 1));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top == -1 || stack[top] != s[i]) {
            stack[++top] = s[i];
        } else {
            top--;
        }
    }

    stack[top + 1] = '\0';
    return stack;
}