#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeOuterParentheses(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;
    int balance = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            balance++;
        } else {
            balance--;
        }

        if (balance == 0) {
            continue;
        } else {
            result[index++] = s[i];
        }
    }

    result[index] = '\0';
    return result;
}