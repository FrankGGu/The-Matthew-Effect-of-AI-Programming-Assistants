#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char*** getLastVisitedIntegers(char** words, int wordsSize, int* returnSize, int** returnColumnSizes) {
    char*** result = (char***)malloc(sizeof(char**) * wordsSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * wordsSize);
    *returnSize = 0;

    int currentLength = 0;
    char** currentList = NULL;

    for (int i = 0; i < wordsSize; i++) {
        if (words[i][0] >= '0' && words[i][0] <= '9') {
            currentList = (char**)realloc(currentList, sizeof(char*) * (currentLength + 1));
            currentList[currentLength++] = strdup(words[i]);
        } else {
            if (currentLength > 0) {
                result[*returnSize] = (char**)malloc(sizeof(char*) * currentLength);
                for (int j = 0; j < currentLength; j++) {
                    result[*returnSize][j] = currentList[j];
                }
                (*returnColumnSizes)[*returnSize] = currentLength;
                (*returnSize)++;
                currentList = NULL;
                currentLength = 0;
            }
        }
    }

    if (currentLength > 0) {
        result[*returnSize] = (char**)malloc(sizeof(char*) * currentLength);
        for (int j = 0; j < currentLength; j++) {
            result[*returnSize][j] = currentList[j];
        }
        (*returnColumnSizes)[*returnSize] = currentLength;
        (*returnSize)++;
    }

    return result;
}