#include <string.h>
#include <stdlib.h>

int longestValidParentheses(char *s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int *stack = (int *)malloc((n + 1) * sizeof(int));
    int top = -1;

    stack[++top] = -1;

    int maxLength = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else {
            top--;

            if (top == -1) {
                stack[++top] = i;
            } else {
                int currentLength = i - stack[top];
                if (currentLength > maxLength) {
                    maxLength = currentLength;
                }
            }
        }
    }

    free(stack);
    return maxLength;
}