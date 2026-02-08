#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **removeComments(char **source, int sourceSize, int *returnSize) {
    char **result = malloc(sourceSize * sizeof(char *));
    int resIndex = 0;
    int inBlockComment = 0;
    char line[1024];

    for (int i = 0; i < sourceSize; i++) {
        int j = 0;
        while (source[i][j]) {
            if (!inBlockComment && source[i][j] == '/' && source[i][j + 1] == '*') {
                inBlockComment = 1;
                j++;
            } else if (inBlockComment && source[i][j] == '*' && source[i][j + 1] == '/') {
                inBlockComment = 0;
                j++;
            } else if (!inBlockComment && source[i][j] == '/' && source[i][j + 1] == '/') {
                break;
            } else if (!inBlockComment) {
                line[strlen(line)] = source[i][j];
            }
            j++;
        }
        if (!inBlockComment && strlen(line) > 0) {
            line[strlen(line)] = '\0';
            result[resIndex++] = strdup(line);
            memset(line, 0, sizeof(line));
        }
    }

    *returnSize = resIndex;
    return realloc(result, resIndex * sizeof(char *));
}