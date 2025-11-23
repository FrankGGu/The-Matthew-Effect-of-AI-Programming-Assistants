#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** generateParenthesis(int n, int* returnSize) {
    char** result = (char**)malloc(10000 * sizeof(char*));
    *returnSize = 0;

    void backtrack(char* current, int open, int close, int pos) {
        if (close == n) {
            result[(*returnSize)++] = strdup(current);
            return;
        }
        if (open < n) {
            current[pos] = '(';
            backtrack(current, open + 1, close, pos + 1);
        }
        if (close < open) {
            current[pos] = ')';
            backtrack(current, open, close + 1, pos + 1);
        }
    }

    char* current = (char*)malloc(2 * n + 1);
    current[2 * n] = '\0';
    backtrack(current, 0, 0, 0);
    free(current);

    return result;
}