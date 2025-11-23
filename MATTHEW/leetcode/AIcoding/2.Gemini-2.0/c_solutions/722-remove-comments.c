#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** removeComments(char ** source, int sourceSize, int* returnSize){
    char ** result = (char **)malloc(sourceSize * sizeof(char *));
    *returnSize = 0;
    char * currentLine = (char *)malloc(1000 * sizeof(char));
    int currentLineIndex = 0;
    int inBlockComment = 0;

    for (int i = 0; i < sourceSize; i++) {
        char * line = source[i];
        for (int j = 0; line[j] != '\0'; j++) {
            if (inBlockComment) {
                if (line[j] == '*' && line[j + 1] == '/') {
                    inBlockComment = 0;
                    j++;
                }
            } else {
                if (line[j] == '/' && line[j + 1] == '*') {
                    inBlockComment = 1;
                    j++;
                } else if (line[j] == '/' && line[j + 1] == '/') {
                    break;
                } else {
                    currentLine[currentLineIndex++] = line[j];
                }
            }
        }
        if (!inBlockComment && currentLineIndex > 0) {
            currentLine[currentLineIndex] = '\0';
            result[*returnSize] = (char *)malloc((currentLineIndex + 1) * sizeof(char));
            strcpy(result[*returnSize], currentLine);
            (*returnSize)++;
            currentLineIndex = 0;
        }
    }
    free(currentLine);
    return result;
}