#include <stdbool.h>
#include <string.h>

bool isValid(char * s) {
    int len = strlen(s);
    char stack[len];
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(' || s[i] == '{' || s[i] == '[') {
            stack[++top] = s[i];
        } else {
            if (top == -1) return false;
            char last = stack[top--];
            if ((s[i] == ')' && last != '(') || 
                (s[i] == '}' && last != '{') || 
                (s[i] == ']' && last != '[')) {
                return false;
            }
        }
    }
    return top == -1;
}