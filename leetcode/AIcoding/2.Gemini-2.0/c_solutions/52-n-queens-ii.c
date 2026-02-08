#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalNQueens(int n) {
    int count = 0;
    bool* cols = (bool*)malloc(n * sizeof(bool));
    bool* diag1 = (bool*)malloc((2 * n - 1) * sizeof(bool));
    bool* diag2 = (bool*)malloc((2 * n - 1) * sizeof(bool));

    for (int i = 0; i < n; i++) cols[i] = false;
    for (int i = 0; i < 2 * n - 1; i++) diag1[i] = false;
    for (int i = 0; i < 2 * n - 1; i++) diag2[i] = false;

    void backtrack(int row) {
        if (row == n) {
            count++;
            return;
        }

        for (int col = 0; col < n; col++) {
            if (cols[col] || diag1[row + col] || diag2[row - col + n - 1]) continue;

            cols[col] = diag1[row + col] = diag2[row - col + n - 1] = true;
            backtrack(row + 1);
            cols[col] = diag1[row + col] = diag2[row - col + n - 1] = false;
        }
    }

    backtrack(0);

    free(cols);
    free(diag1);
    free(diag2);

    return count;
}