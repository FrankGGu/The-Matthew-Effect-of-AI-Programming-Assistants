#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeAdjacent(char * s){
    int len = strlen(s);
    char * stack = (char *)malloc((len + 1) * sizeof(char));
    int top = -1;
    for(int i = 0; i < len; i++){
        if(top == -1 || stack[top] != s[i]){
            stack[++top] = s[i];
        } else {
            top--;
        }
    }
    stack[top + 1] = '\0';

    char * result = (char *)malloc((top + 2) * sizeof(char));
    for(int i = 0; i <= top; i++){
        result[i] = stack[i];
    }
    result[top + 1] = '\0';

    free(stack);
    return result;
}