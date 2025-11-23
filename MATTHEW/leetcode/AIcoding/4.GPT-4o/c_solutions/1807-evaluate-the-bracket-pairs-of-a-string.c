#include <stdbool.h>
#include <string.h>

bool canEvaluate(char *s) {
    int stack[1000];
    int top = -1;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            stack[++top] = 1;
        } else if (s[i] == ')') {
            if (top == -1 || stack[top] != 1) return false;
            top--;
        } else if (s[i] == '[') {
            stack[++top] = 2;
        } else if (s[i] == ']') {
            if (top == -1 || stack[top] != 2) return false;
            top--;
        } else if (s[i] == '{') {
            stack[++top] = 3;
        } else if (s[i] == '}') {
            if (top == -1 || stack[top] != 3) return false;
            top--;
        }
    }
    return top == -1;
}