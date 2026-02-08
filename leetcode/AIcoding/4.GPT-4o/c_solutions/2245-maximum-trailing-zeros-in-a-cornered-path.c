int maxTrailingZeros(int** grid, int gridSize, int* gridColSize) {
    int maxZeros = 0;
    int rows = gridSize, cols = gridColSize[0];
    int countOf2[rows][cols], countOf5[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int num = grid[i][j];
            countOf2[i][j] = (num == 0) ? 0 : __builtin_ctz(num);
            countOf5[i][j] = (num == 0) ? 0 : __builtin_ctz(num / (1 << countOf2[i][j]));
            if (i > 0) {
                countOf2[i][j] += countOf2[i - 1][j];
                countOf5[i][j] += countOf5[i - 1][j];
            }
            if (j > 0) {
                countOf2[i][j] += countOf2[i][j - 1];
                countOf5[i][j] += countOf5[i][j - 1];
                if (i > 0) {
                    countOf2[i][j] -= countOf2[i - 1][j - 1];
                    countOf5[i][j] -= countOf5[i - 1][j - 1];
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int zeros = fmin(countOf2[i][j], countOf5[i][j]);
            maxZeros = fmax(maxZeros, zeros);
        }
    }

    return maxZeros;
}