#include <string.h>
#include <stdlib.h>

void reverse(char* s, int start, int end) {
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }
}

char* reverseParentheses(char* s) {
    int n = strlen(s);
    // The maximum possible length of the resulting string is n (if no parentheses removed)
    // or less (if parentheses are removed). We allocate n+1 for the null terminator.
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int result_len = 0;

    // The stack will store indices in the 'result' array where a new reversal segment begins.
    // Max stack depth can be n/2 (e.g., "((()))").
    int* stack = (int*)malloc(sizeof(int) * (n / 2 + 1));
    int stack_top = -1; // Represents an empty stack

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            // Push the current length of the 'result' string onto the stack.
            // This marks the starting position for a potential reversal.
            stack_top++;
            stack[stack_top] = result_len;
        } else if (s[i] == ')') {
            // Pop the starting index for the current segment to be reversed.
            int start_idx = stack[stack_top];
            stack_top--;
            // Reverse the substring in 'result' from start_idx to result_len - 1.
            reverse(result, start_idx, result_len - 1);
        } else {
            // If it's a letter, append it to the 'result' string.
            result[result_len] = s[i];
            result_len++;
        }
    }

    // Null-terminate the final result string.
    result[result_len] = '\0';

    // Free the dynamically allocated stack as it's no longer needed.
    free(stack);

    // Return the dynamically allocated result string.
    // The caller is responsible for freeing this memory.
    return result;
}