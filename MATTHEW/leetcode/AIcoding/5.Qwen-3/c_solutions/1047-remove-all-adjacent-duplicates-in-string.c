#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeDuplicates(char* s) {
    int len = strlen(s);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && stack[top] == s[i]) {
            top--;
        } else {
            stack[++top] = s[i];
        }
    }

    stack[++top] = '\0';
    return stack;
}