#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char * s){
    int len = 0;
    while(s[len] != '\0'){
        len++;
    }

    if (len % 2 != 0) return false;

    char *stack = (char*)malloc(sizeof(char) * (len / 2 + 1));
    int top = -1;

    for(int i = 0; i < len; i++){
        if(s[i] == '(' || s[i] == '[' || s[i] == '{'){
            stack[++top] = s[i];
        } else {
            if(top == -1) return false;

            if((s[i] == ')' && stack[top] == '(') ||
               (s[i] == ']' && stack[top] == '[') ||
               (s[i] == '}' && stack[top] == '{')){
                top--;
            } else {
                free(stack);
                return false;
            }
        }
    }

    free(stack);
    return top == -1;
}