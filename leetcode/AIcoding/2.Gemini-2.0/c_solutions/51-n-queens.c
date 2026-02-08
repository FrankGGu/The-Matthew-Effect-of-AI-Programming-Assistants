#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *** solveNQueens(int n, int* returnSize, int** returnColumnSizes){
    char ***result = NULL;
    int *queens = (int*)malloc(sizeof(int) * n);
    *returnSize = 0;
    *returnColumnSizes = NULL;

    void backtrack(int row) {
        if (row == n) {
            (*returnSize)++;
            result = (char***)realloc(result, sizeof(char**) * (*returnSize));
            (*returnColumnSizes) = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize));
            (*returnColumnSizes)[*returnSize - 1] = n;
            result[*returnSize - 1] = (char**)malloc(sizeof(char*) * n);
            for (int i = 0; i < n; i++) {
                result[*returnSize - 1][i] = (char*)malloc(sizeof(char) * (n + 1));
                for (int j = 0; j < n; j++) {
                    result[*returnSize - 1][i][j] = '.';
                }
                result[*returnSize - 1][i][queens[i]] = 'Q';
                result[*returnSize - 1][i][n] = '\0';
            }
            return;
        }

        for (int col = 0; col < n; col++) {
            int valid = 1;
            for (int i = 0; i < row; i++) {
                if (queens[i] == col || queens[i] - col == i - row || queens[i] - col == row - i) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                queens[row] = col;
                backtrack(row + 1);
            }
        }
    }

    backtrack(0);
    free(queens);
    return result;
}