#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* buildString(char* s, int size) {
    char* result = (char*)malloc((size + 1) * sizeof(char));
    if (!result) return NULL;
    strncpy(result, s, size);
    result[size] = '\0';
    return result;
}

bool isValid(char* s) {
    int len = strlen(s);
    char* stack = (char*)malloc(len * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == 'a' || s[i] == 'b' || s[i] == 'c') {
            if (top >= 0 && s[i] == 'c' && top >= 1 && stack[top - 1] == 'b' && stack[top] == 'a') {
                top -= 2;
            } else {
                stack[++top] = s[i];
            }
        } else {
            free(stack);
            return false;
        }
    }

    bool result = (top == -1);
    free(stack);
    return result;
}