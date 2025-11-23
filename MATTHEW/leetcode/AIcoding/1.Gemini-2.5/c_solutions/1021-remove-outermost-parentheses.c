#include <stdlib.h>
#include <string.h>

char* removeOuterParentheses(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int result_idx = 0;
    int balance = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            if (balance > 0) {
                result[result_idx++] = '(';
            }
            balance++;
        } else {
            balance--;
            if (balance > 0) {
                result[result_idx++] = ')';
            }
        }
    }
    result[result_idx] = '\0';
    return result;
}