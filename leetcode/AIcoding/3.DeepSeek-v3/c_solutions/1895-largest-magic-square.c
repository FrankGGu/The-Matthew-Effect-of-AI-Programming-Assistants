int largestMagicSquare(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** rowSum = (int**)malloc((m + 1) * sizeof(int*));
    int** colSum = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        rowSum[i] = (int*)calloc(n + 1, sizeof(int));
        colSum[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            rowSum[i + 1][j + 1] = rowSum[i + 1][j] + grid[i][j];
            colSum[i + 1][j + 1] = colSum[i][j + 1] + grid[i][j];
        }
    }

    int maxSize = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = maxSize + 1; k <= fmin(m - i, n - j); k++) {
                int r = i + k - 1;
                int c = j + k - 1;

                int sum = rowSum[i + 1][c + 1] - rowSum[i + 1][j];

                int valid = 1;
                for (int x = i; x <= r; x++) {
                    if (rowSum[x + 1][c + 1] - rowSum[x + 1][j] != sum) {
                        valid = 0;
                        break;
                    }
                }
                if (!valid) continue;

                for (int y = j; y <= c; y++) {
                    if (colSum[r + 1][y + 1] - colSum[i][y + 1] != sum) {
                        valid = 0;
                        break;
                    }
                }
                if (!valid) continue;

                int diag1 = 0;
                for (int d = 0; d < k; d++) {
                    diag1 += grid[i + d][j + d];
                }
                if (diag1 != sum) continue;

                int diag2 = 0;
                for (int d = 0; d < k; d++) {
                    diag2 += grid[i + d][c - d];
                }
                if (diag2 != sum) continue;

                maxSize = k;
            }
        }
    }

    for (int i = 0; i <= m; i++) {
        free(rowSum[i]);
        free(colSum[i]);
    }
    free(rowSum);
    free(colSum);

    return maxSize;
}