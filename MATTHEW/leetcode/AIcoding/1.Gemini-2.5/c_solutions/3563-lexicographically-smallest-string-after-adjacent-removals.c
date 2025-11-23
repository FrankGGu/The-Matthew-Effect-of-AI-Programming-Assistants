#include <stdlib.h>
#include <string.h>

char *smallestString(char *s, int k) {
    int n = strlen(s);
    char *stack = (char *)malloc(sizeof(char) * (n + 1));
    int top = -1;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];
        while (top >= 0 && k > 0 && stack[top] > current_char) {
            top--;
            k--;
        }
        top++;
        stack[top] = current_char;
    }

    while (k > 0 && top >= 0) {
        top--;
        k--;
    }

    stack[top + 1] = '\0';

    char *result = (char *)malloc(sizeof(char) * (top + 2));
    strncpy(result, stack, top + 1);
    result[top + 1] = '\0';

    free(stack);

    return result;
}