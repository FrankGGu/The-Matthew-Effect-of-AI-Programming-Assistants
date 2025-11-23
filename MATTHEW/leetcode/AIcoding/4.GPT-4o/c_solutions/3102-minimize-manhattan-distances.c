int minDistance(int** grid, int gridSize, int* gridColSize) {
    int totalDistance = 0;
    int n = gridSize;
    int m = gridColSize[0];

    int *rowSum = (int *)malloc(n * sizeof(int));
    int *colSum = (int *)malloc(m * sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                rowSum[i]++;
                colSum[j]++;
            }
        }
    }

    int row = 0, col = 0;
    for (int i = 0; i < n; i++) {
        if (rowSum[i] > 0) {
            row += rowSum[i];
        }
    }
    for (int j = 0; j < m; j++) {
        if (colSum[j] > 0) {
            col += colSum[j];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                totalDistance += abs(i - row) + abs(j - col);
            }
        }
    }

    free(rowSum);
    free(colSum);

    return totalDistance;
}