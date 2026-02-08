#include <stdbool.h>
#include <string.h>

bool isValid(char * s) {
    int n = strlen(s);
    if (n == 0) {
        return true;
    }

    char *stack = (char *)malloc(sizeof(char) * (n + 1));
    if (stack == NULL) {
        // Handle allocation failure, though LeetCode usually guarantees it
        return false; 
    }
    int top = -1; // Stack is empty

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (current_char == '(' || current_char == '{' || current_char == '[') {
            top++;
            stack[top] = current_char;
        } else { // Closing bracket
            if (top == -1) { // Stack is empty, no matching opening bracket
                free(stack);
                return false;
            }

            char last_open = stack[top];
            top--; // Pop

            if (current_char == ')' && last_open != '(') {
                free(stack);
                return false;
            }
            if (current_char == '}' && last_open != '{') {
                free(stack);
                return false;
            }
            if (current_char == ']' && last_open != '[') {
                free(stack);
                return false;
            }
        }
    }

    bool result = (top == -1);
    free(stack);
    return result;
}