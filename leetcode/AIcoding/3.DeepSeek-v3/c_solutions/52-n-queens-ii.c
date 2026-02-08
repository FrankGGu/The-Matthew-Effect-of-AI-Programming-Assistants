int totalNQueens(int n) {
    int count = 0;
    int *columns = (int*)calloc(n, sizeof(int));
    int *diag1 = (int*)calloc(2 * n, sizeof(int));
    int *diag2 = (int*)calloc(2 * n, sizeof(int));

    void backtrack(int row) {
        if (row == n) {
            count++;
            return;
        }

        for (int col = 0; col < n; col++) {
            int d1 = row - col + n;
            int d2 = row + col;

            if (columns[col] || diag1[d1] || diag2[d2]) {
                continue;
            }

            columns[col] = diag1[d1] = diag2[d2] = 1;
            backtrack(row + 1);
            columns[col] = diag1[d1] = diag2[d2] = 0;
        }
    }

    backtrack(0);
    free(columns);
    free(diag1);
    free(diag2);
    return count;
}