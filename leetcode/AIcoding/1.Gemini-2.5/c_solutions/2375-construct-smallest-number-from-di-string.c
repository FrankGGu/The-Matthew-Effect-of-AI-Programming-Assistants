#include <stdlib.h>
#include <string.h>

char* constructSmallestNumber(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (n + 2)); // n+1 digits + null terminator
    int result_idx = 0;

    char stack[10]; // Max 9 digits (n+1), plus one for safety (index 0-9)
    int stack_top = -1; // Stack is empty

    int current_digit = 1; // Digits to use, starting from 1

    // Iterate through the pattern string and one extra iteration for the last digit
    for (int i = 0; i <= n; ++i) {
        // Push the current digit onto the stack
        stack[++stack_top] = current_digit + '0';
        current_digit++;

        // If we encounter an 'I' or reach the end of the string,
        // it means the current sequence of 'D's (if any) has ended.
        // Pop all elements from the stack and append them to the result string.
        // This effectively reverses the digits for 'D' sequences,
        // ensuring they are in decreasing order, while maintaining
        // the lexicographically smallest property by using the smallest available digits.
        if (i == n || s[i] == 'I') {
            while (stack_top != -1) {
                result[result_idx++] = stack[stack_top--];
            }
        }
    }

    result[result_idx] = '\0'; // Null-terminate the result string
    return result;
}