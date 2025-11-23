#include <stdlib.h>
#include <string.h>

char * simplifyPath(char * path) {
    char *stack[500];
    int top = -1;

    char *token = strtok(path, "/");

    while (token != NULL) {
        if (strcmp(token, ".") == 0 || strcmp(token, "") == 0) {
            // Ignore "." and empty tokens (due to multiple slashes)
        } else if (strcmp(token, "..") == 0) {
            // Go up one directory if stack is not empty
            if (top != -1) {
                top--;
            }
        } else {
            // It's a directory name, push onto stack
            top++;
            stack[top] = token;
        }
        token = strtok(NULL, "/");
    }

    char *result = (char *)malloc(strlen(path) + 2);
    if (result == NULL) {
        return NULL;
    }
    result[0] = '\0';

    if (top == -1) {
        strcpy(result, "/");
    } else {
        for (int i = 0; i <= top; i++) {
            strcat(result, "/");
            strcat(result, stack[i]);
        }
    }

    return result;
}