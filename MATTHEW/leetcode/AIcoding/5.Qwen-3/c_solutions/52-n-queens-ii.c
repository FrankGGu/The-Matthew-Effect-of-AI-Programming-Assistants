#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalNQueens(int n) {
    int count = 0;
    int *board = (int *)malloc(n * sizeof(int));
    int *cols = (int *)malloc(n * sizeof(int));
    int *diag1 = (int *)malloc((2 * n - 1) * sizeof(int));
    int *diag2 = (int *)malloc((2 * n - 1) * sizeof(int));

    void backtrack(int row) {
        if (row == n) {
            count++;
            return;
        }
        for (int col = 0; col < n; col++) {
            int d1 = row - col + n - 1;
            int d2 = row + col;
            if (!cols[col] && !diag1[d1] && !diag2[d2]) {
                cols[col] = 1;
                diag1[d1] = 1;
                diag2[d2] = 1;
                board[row] = col;
                backtrack(row + 1);
                cols[col] = 0;
                diag1[d1] = 0;
                diag2[d2] = 0;
            }
        }
    }

    backtrack(0);
    free(board);
    free(cols);
    free(diag1);
    free(diag2);
    return count;
}