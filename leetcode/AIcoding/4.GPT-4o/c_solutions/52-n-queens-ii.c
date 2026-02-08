int totalNQueens(int n) {
    int count = 0;
    int *cols = (int *)malloc(n * sizeof(int));
    int *diag1 = (int *)malloc((2 * n - 1) * sizeof(int));
    int *diag2 = (int *)malloc((2 * n - 1) * sizeof(int));

    for (int i = 0; i < n; i++) {
        cols[i] = 0;
    }
    for (int i = 0; i < 2 * n - 1; i++) {
        diag1[i] = diag2[i] = 0;
    }

    void backtrack(int row) {
        if (row == n) {
            count++;
            return;
        }
        for (int col = 0; col < n; col++) {
            if (!cols[col] && !diag1[row + col] && !diag2[row - col + n - 1]) {
                cols[col] = diag1[row + col] = diag2[row - col + n - 1] = 1;
                backtrack(row + 1);
                cols[col] = diag1[row + col] = diag2[row - col + n - 1] = 0;
            }
        }
    }

    backtrack(0);
    free(cols);
    free(diag1);
    free(diag2);
    return count;
}