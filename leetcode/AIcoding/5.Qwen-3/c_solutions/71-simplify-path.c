#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* simplifyPath(char* path) {
    int len = strlen(path);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;
    for (int i = 0; i < len; i++) {
        if (path[i] == '/') {
            if (top >= 0 && stack[top] != '/') {
                stack[++top] = '/';
            }
        } else if (path[i] == '.' && (i + 1 >= len || path[i + 1] == '/')) {
            if (top >= 0 && stack[top] == '/') {
                if (i + 1 < len && path[i + 1] == '.') {
                    if (top > 0) {
                        top--;
                        while (top >= 0 && stack[top] != '/') {
                            top--;
                        }
                    }
                    i++;
                }
            } else {
                i++;
                while (i < len && path[i] != '/') {
                    i++;
                }
            }
        } else {
            stack[++top] = path[i];
        }
    }
    if (top >= 0 && stack[top] == '/') {
        top--;
    }
    stack[++top] = '\0';
    return stack;
}