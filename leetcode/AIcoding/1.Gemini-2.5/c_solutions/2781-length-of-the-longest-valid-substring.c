#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestValidParentheses(char * s){
    int n = strlen(s);

    // Stack to store indices
    // Max size n for indices + 1 for initial -1
    int *stack = (int *)malloc(sizeof(int) * (n + 1));
    int top = -1; // Stack top pointer

    // Push initial -1 onto the stack. This acts as a base for length calculation.
    stack[++top] = -1;

    int max_len = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            stack[++top] = i; // Push current index
        } else { // s[i] == ')'
            top--; // Pop from stack
            if (top == -1) { // Stack became empty after popping, meaning this ')' doesn't have a matching '('
                stack[++top] = i; // Push current index as a new base for subsequent valid substrings
            } else { // Stack is not empty, meaning a matching '(' was found
                // Calculate the length of the current valid substring
                // It ends at 'i' and starts just after the index at stack[top]
                max_len = max(max_len, i - stack[top]);
            }
        }
    }

    free(stack); // Free allocated memory
    return max_len;
}