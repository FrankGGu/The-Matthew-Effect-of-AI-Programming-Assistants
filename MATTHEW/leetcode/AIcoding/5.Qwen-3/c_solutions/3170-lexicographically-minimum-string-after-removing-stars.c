#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeStars(char* s) {
    int len = strlen(s);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int top = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '*') {
            if (top > 0) {
                top--;
            }
        } else {
            stack[top++] = s[i];
        }
    }

    stack[top] = '\0';
    return stack;
}