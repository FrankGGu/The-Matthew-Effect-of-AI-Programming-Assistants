#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** generateParenthesis(int n, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * 2000);
    *returnSize = 0;

    void backtrack(char* current, int open, int close) {
        if (strlen(current) == 2 * n) {
            result[*returnSize] = (char*)malloc(strlen(current) + 1);
            strcpy(result[*returnSize], current);
            (*returnSize)++;
            return;
        }

        if (open < n) {
            current[strlen(current)] = '(';
            backtrack(current, open + 1, close);
            current[strlen(current)] = '\0';
        }

        if (close < open) {
            current[strlen(current)] = ')';
            backtrack(current, open, close + 1);
            current[strlen(current)] = '\0';
        }
    }

    char* temp = (char*)malloc((2 * n + 1) * sizeof(char));
    temp[0] = '\0';
    backtrack(temp, 0, 0);
    free(temp);
    return result;
}