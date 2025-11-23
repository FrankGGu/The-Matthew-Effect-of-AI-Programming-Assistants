#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(char *current, int open, int close, int n, char **result, int *returnSize) {
    if (strlen(current) == 2 * n) {
        result[*returnSize] = (char *)malloc(2 * n + 1);
        strcpy(result[*returnSize], current);
        (*returnSize)++;
        return;
    }
    if (open < n) {
        current[strlen(current)] = '(';
        backtrack(current, open + 1, close, n, result, returnSize);
        current[strlen(current)] = '\0';
    }
    if (close < open) {
        current[strlen(current)] = ')';
        backtrack(current, open, close + 1, n, result, returnSize);
        current[strlen(current)] = '\0';
    }
}

char **generateParenthesis(int n, int *returnSize) {
    char **result = (char **)malloc(sizeof(char *) * (pow(2, 2 * n)));
    *returnSize = 0;
    char *current = (char *)malloc((2 * n + 1) * sizeof(char));
    backtrack(current, 0, 0, n, result, returnSize);
    free(current);
    return result;
}