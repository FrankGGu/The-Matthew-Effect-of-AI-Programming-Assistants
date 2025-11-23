#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *removeStars(char *s) {
    int n = strlen(s);
    char *stack = (char *)malloc((n + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            if (top >= 0) {
                top--;
            }
        } else {
            stack[++top] = s[i];
        }
    }

    stack[top + 1] = '\0';
    char *result = (char *)malloc((top + 2) * sizeof(char));
    strcpy(result, stack);

    free(stack);
    return result;
}