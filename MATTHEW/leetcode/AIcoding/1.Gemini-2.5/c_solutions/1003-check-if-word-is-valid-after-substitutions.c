#include <stdbool.h>
#include <string.h>

bool isValid(char * s) {
    int len = strlen(s);
    if (len % 3 != 0) {
        return false;
    }

    char stack[len + 1];
    int top = -1;

    for (int i = 0; i < len; i++) {
        char c = s[i];
        if (c == 'a' || c == 'b') {
            stack[++top] = c;
        } else if (c == 'c') {
            if (top >= 1 && stack[top] == 'b' && stack[top - 1] == 'a') {
                top -= 2;
            } else {
                return false;
            }
        }
    }

    return top == -1;
}