#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isValid(char * s) {
    int n = strlen(s);
    if (n == 0) {
        return true;
    }

    char *stack = (char *)malloc(sizeof(char) * n);
    if (stack == NULL) {
        return false; 
    }
    int top = -1;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (current_char == '(' || current_char == '[' || current_char == '{') {
            top++;
            stack[top] = current_char;
        } else if (current_char == ')' || current_char == ']' || current_char == '}') {
            if (top == -1) {
                free(stack);
                return false;
            }

            char last_open = stack[top];
            top--;

            if (current_char == ')' && last_open != '(') {
                free(stack);
                return false;
            }
            if (current_char == ']' && last_open != '[') {
                free(stack);
                return false;
            }
            if (current_char == '}' && last_open != '{') {
                free(stack);
                return false;
            }
        }
    }

    bool result = (top == -1);
    free(stack);
    return result;
}