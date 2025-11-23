#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseParentheses(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    char** stack = (char**)malloc(len * sizeof(char*));
    int top = -1;
    int resultIndex = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = result;
            result = (char*)malloc((len + 1) * sizeof(char));
            resultIndex = 0;
        } else if (s[i] == ')') {
            char* temp = (char*)malloc((resultIndex + 1) * sizeof(char));
            strncpy(temp, result, resultIndex);
            temp[resultIndex] = '\0';
            free(result);
            result = stack[top--];
            int j = 0;
            while (temp[j]) {
                result[resultIndex++] = temp[strlen(temp) - 1 - j];
                j++;
            }
            free(temp);
        } else {
            result[resultIndex++] = s[i];
        }
    }

    result[resultIndex] = '\0';
    return result;
}