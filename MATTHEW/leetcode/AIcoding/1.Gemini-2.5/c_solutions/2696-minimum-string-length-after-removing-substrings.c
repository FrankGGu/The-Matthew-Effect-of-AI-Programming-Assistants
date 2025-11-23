#include <string.h>

int minLength(char* s) {
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    char stack[n + 1];
    int top = -1;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (top != -1) {
            char stack_top_char = stack[top];

            if ((stack_top_char == 'A' && current_char == 'B') ||
                (stack_top_char == 'C' && current_char == 'D')) {
                top--;
            } else {
                top++;
                stack[top] = current_char;
            }
        } else {
            top++;
            stack[top] = current_char;
        }
    }

    return top + 1;
}