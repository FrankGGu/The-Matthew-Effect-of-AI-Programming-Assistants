#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *simplifyPath(char *path) {
    char **stack = (char **)malloc(sizeof(char *) * (strlen(path) + 1));
    int top = -1;
    char *token = strtok(path, "/");
    while (token != NULL) {
        if (strcmp(token, "..") == 0) {
            if (top >= 0) {
                free(stack[top]);
                top--;
            }
        } else if (strcmp(token, ".") != 0 && strlen(token) > 0) {
            stack[++top] = (char *)malloc(sizeof(char) * (strlen(token) + 1));
            strcpy(stack[top], token);
        }
        token = strtok(NULL, "/");
    }
    if (top == -1) {
        char *result = (char *)malloc(sizeof(char) * 2);
        strcpy(result, "/");
        free(stack);
        return result;
    }
    int len = 1;
    for (int i = 0; i <= top; i++) {
        len += strlen(stack[i]) + 1;
    }
    char *result = (char *)malloc(sizeof(char) * len);
    result[0] = '/';
    result[1] = '\0';
    for (int i = 0; i <= top; i++) {
        strcat(result, stack[i]);
        if (i < top) {
            strcat(result, "/");
        }
        free(stack[i]);
    }
    free(stack);
    return result;
}