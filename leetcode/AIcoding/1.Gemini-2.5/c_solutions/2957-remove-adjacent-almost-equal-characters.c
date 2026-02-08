#include <string.h>
#include <stdlib.h>

int minLengthAfterRemovals(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    char *stack = (char *)malloc(sizeof(char) * n);
    if (stack == NULL) {
        return 0; 
    }

    int top = 0;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];
        if (top > 0 && abs(current_char - stack[top - 1]) <= 1) {
            top--;
        } else {
            stack[top] = current_char;
            top++;
        }
    }

    free(stack);
    return top;
}