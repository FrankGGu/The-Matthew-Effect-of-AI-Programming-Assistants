#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void solveNQueensUtil(int n, int row, int* column, int* leftDiagonal, int* rightDiagonal, char*** result, int* returnSize, char** board) {
    if (row == n) {
        result[(*returnSize)++] = strdup(board[0]);
        return;
    }
    for (int col = 0; col < n; col++) {
        if (column[col] || leftDiagonal[row - col + n - 1] || rightDiagonal[row + col]) continue;
        column[col] = leftDiagonal[row - col + n - 1] = rightDiagonal[row + col] = 1;
        board[row][col] = 'Q';
        solveNQueensUtil(n, row + 1, column, leftDiagonal, rightDiagonal, result, returnSize, board);
        column[col] = leftDiagonal[row - col + n - 1] = rightDiagonal[row + col] = 0;
        board[row][col] = '.';
    }
}

char*** solveNQueens(int n, int* returnSize, int** returnColumnSizes) {
    char*** result = (char***)malloc(100 * sizeof(char**));
    *returnSize = 0;
    int* column = (int*)calloc(n, sizeof(int));
    int* leftDiagonal = (int*)calloc(2 * n - 1, sizeof(int));
    int* rightDiagonal = (int*)calloc(2 * n - 1, sizeof(int));
    char** board = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        board[i] = (char*)malloc((n + 1) * sizeof(char));
        memset(board[i], '.', n);
        board[i][n] = '\0';
    }
    solveNQueensUtil(n, 0, column, leftDiagonal, rightDiagonal, result, returnSize, board);
    free(column);
    free(leftDiagonal);
    free(rightDiagonal);
    for (int i = 0; i < n; i++) free(board[i]);
    free(board);
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = n;
    }
    return result;
}