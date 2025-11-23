#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

void backtrack(char *s, int start, int n, int **result, int *returnSize, int *columnSizes, int *currentList, int currentSize) {
    if (start == n) {
        (*returnSize)++;
        *result = (int *)realloc(*result, (*returnSize) * sizeof(int));
        (*result)[(*returnSize) - 1] = (int *)malloc(currentSize * sizeof(int));

        columnSizes[*returnSize - 1] = currentSize;

        for (int i = 0; i < currentSize; i++) {
            ((int *)(*result)[(*returnSize) - 1])[i] = currentList[i];
        }

        return;
    }

    for (int i = start; i < n; i++) {
        if (isPalindrome(s, start, i)) {
            char sub[i - start + 2];
            strncpy(sub, s + start, i - start + 1);
            sub[i - start + 1] = '\0';

            currentList[currentSize] = (int)malloc(strlen(sub) + 1);
            strcpy((char*)currentList[currentSize], sub);

            backtrack(s, i + 1, n, result, returnSize, columnSizes, currentList, currentSize + 1);
             free((char*)currentList[currentSize]);
        }
    }
}

char *** partition(char * s, int* returnSize, int** returnColumnSizes){
    int n = strlen(s);
    int *result = NULL;
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(1000 * sizeof(int));
    int *currentList = (int *)malloc(n * sizeof(int));

    backtrack(s, 0, n, &result, returnSize, *returnColumnSizes, currentList, 0);

    char ***finalResult = (char ***)malloc(*returnSize * sizeof(char **));
    for (int i = 0; i < *returnSize; i++) {
        finalResult[i] = (char **)malloc((*returnColumnSizes)[i] * sizeof(char *));
        for (int j = 0; j < (*returnColumnSizes)[i]; j++) {
            finalResult[i][j] = (char *)((int *)(result)[i])[j];
        }
    }
     free(result);
    free(currentList);
    return finalResult;
}