#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *simplifyPath(char *path) {
    char **stack = malloc(strlen(path) * sizeof(char *));
    int stackSize = 0;
    char *token = strtok(path, "/");

    while (token != NULL) {
        if (strcmp(token, "") != 0 && strcmp(token, ".") != 0) {
            if (strcmp(token, "..") == 0) {
                if (stackSize > 0) {
                    stackSize--;
                }
            } else {
                stack[stackSize++] = token;
            }
        }
        token = strtok(NULL, "/");
    }

    char *result = malloc(strlen(path) + 1);
    result[0] = '\0';

    for (int i = 0; i < stackSize; i++) {
        strcat(result, "/");
        strcat(result, stack[i]);
    }

    if (stackSize == 0) {
        strcpy(result, "/");
    }

    free(stack);
    return result;
}