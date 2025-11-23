#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char *s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) return false;
        left++;
        right--;
    }
    return true;
}

void backtrack(char **result, int **returnColumnSizes, int *returnSize, char *s, int start, char **path, int pathSize) {
    if (start == strlen(s)) {
        result[*returnSize] = (char *)malloc(sizeof(char *) * pathSize);
        for (int i = 0; i < pathSize; i++) {
            result[*returnSize][i] = path[i];
        }
        returnColumnSizes[0][*returnSize] = pathSize;
        (*returnSize)++;
        return;
    }

    for (int end = start; end < strlen(s); end++) {
        if (isPalindrome(s, start, end)) {
            path[pathSize] = (char *)malloc((end - start + 2) * sizeof(char));
            strncpy(path[pathSize], s + start, end - start + 1);
            path[pathSize][end - start + 1] = '\0';
            backtrack(result, returnColumnSizes, returnSize, s, end + 1, path, pathSize + 1);
            free(path[pathSize]);
        }
    }
}

char ***partition(char *s, int **returnColumnSizes, int *returnSize) {
    int maxSize = 1000;
    char ***result = (char ***)malloc(maxSize * sizeof(char **));
    *returnColumnSizes = (int *)malloc(maxSize * sizeof(int));
    *returnSize = 0;
    char **path = (char **)malloc(strlen(s) * sizeof(char *));
    backtrack(result, returnColumnSizes, returnSize, s, 0, path, 0);
    free(path);
    return result;
}