#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeOuterParentheses(char * s){
    int len = strlen(s);
    char *result = (char*)malloc(sizeof(char) * (len + 1));
    int balance = 0;
    int j = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            if (balance > 0) {
                result[j++] = '(';
            }
            balance++;
        } else {
            balance--;
            if (balance > 0) {
                result[j++] = ')';
            }
        }
    }

    result[j] = '\0';
    return result;
}