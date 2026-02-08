#include <stdlib.h>
#include <stdbool.h>

void solveNQueens(int row, int n, bool* col_used, bool* diag1_used, bool* diag2_used, int* count) {
    if (row == n) {
        (*count)++;
        return;
    }

    for (int col = 0; col < n; col++) {
        int diag1_idx = row - col + n - 1;
        int diag2_idx = row + col;

        if (!col_used[col] && !diag1_used[diag1_idx] && !diag2_used[diag2_idx]) {
            col_used[col] = true;
            diag1_used[diag1_idx] = true;
            diag2_used[diag2_idx] = true;

            solveNQueens(row + 1, n, col_used, diag1_used, diag2_used, count);

            col_used[col] = false;
            diag1_used[diag1_idx] = false;
            diag2_used[diag2_idx] = false;
        }
    }
}

int totalNQueens(int n) {
    if (n <= 0) {
        return 0;
    }

    bool* col_used = (bool*)calloc(n, sizeof(bool));
    bool* diag1_used = (bool*)calloc(2 * n - 1, sizeof(bool));
    bool* diag2_used = (bool*)calloc(2 * n - 1, sizeof(bool));

    int count = 0;

    solveNQueens(0, n, col_used, diag1_used, diag2_used, &count);

    free(col_used);
    free(diag1_used);
    free(diag2_used);

    return count;
}