#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minRemoveToMakeValid(char* s) {
    int len = strlen(s);
    int* stack = (int*)malloc(len * sizeof(int));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else if (s[i] == ')') {
            if (top >= 0) {
                top--;
            } else {
                stack[++top] = i;
            }
        }
    }

    char* result = (char*)malloc((len - top) * sizeof(char));
    int j = 0;
    for (int i = 0; i < len; i++) {
        if (top >= 0 && i == stack[top]) {
            top--;
        } else {
            result[j++] = s[i];
        }
    }

    result[j] = '\0';
    free(stack);
    return result;
}