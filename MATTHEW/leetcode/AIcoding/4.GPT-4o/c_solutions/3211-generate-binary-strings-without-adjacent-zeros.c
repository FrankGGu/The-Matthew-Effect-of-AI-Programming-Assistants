#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(char **result, int *returnSize, char *current, int n, int pos) {
    if (pos == n) {
        result[*returnSize] = strdup(current);
        (*returnSize)++;
        return;
    }

    current[pos] = '1';
    backtrack(result, returnSize, current, n, pos + 1);

    if (pos == 0 || current[pos - 1] != '0') {
        current[pos] = '0';
        backtrack(result, returnSize, current, n, pos + 1);
    }
}

char **generateBinaryStrings(int n, int *returnSize) {
    *returnSize = 0;
    char **result = (char **)malloc(sizeof(char *) * (1 << n));
    char *current = (char *)malloc(sizeof(char) * (n + 1));
    current[n] = '\0';

    backtrack(result, returnSize, current, n, 0);

    free(current);
    return result;
}