#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* evaluate(char* s, char** knowledge) {
    int len = strlen(s);
    char** stack = (char**)malloc(sizeof(char*) * len);
    int top = -1;
    char* result = (char*)malloc(sizeof(char) * len);
    int resIndex = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = (char*)malloc(sizeof(char) * (i - 1 + 1));
            strncpy(stack[top], s, i);
            stack[top][i] = '\0';
            i++;
            int j = i;
            while (j < len && s[j] != ')') j++;
            char* key = (char*)malloc(sizeof(char) * (j - i + 1));
            strncpy(key, s + i, j - i);
            key[j - i] = '\0';
            char* value = NULL;
            for (int k = 0; knowledge[k]; k++) {
                if (strcmp(knowledge[k], key) == 0) {
                    value = knowledge[k + 1];
                    break;
                }
            }
            if (value) {
                strcpy(result + resIndex, value);
                resIndex += strlen(value);
            }
            free(key);
            i = j;
        } else if (s[i] == ')') {
            char* prev = stack[top--];
            strcpy(result + resIndex, prev);
            resIndex += strlen(prev);
            free(prev);
        } else {
            result[resIndex++] = s[i];
        }
    }

    if (top >= 0) {
        char* prev = stack[top];
        strcpy(result + resIndex, prev);
        resIndex += strlen(prev);
        free(prev);
    }

    result[resIndex] = '\0';
    return result;
}