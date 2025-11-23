int minimumOperationsToWriteY(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int yCount[3] = {0};
    int nonYCount[3] = {0};

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((i == j && i <= n/2) || 
                (i + j == n - 1 && i <= n/2) || 
                (i > n/2 && j == n/2)) {
                yCount[grid[i][j]]++;
            } else {
                nonYCount[grid[i][j]]++;
            }
        }
    }

    int minOps = INT_MAX;
    for (int yVal = 0; yVal < 3; yVal++) {
        for (int nonYVal = 0; nonYVal < 3; nonYVal++) {
            if (yVal == nonYVal) continue;

            int ops = 0;
            for (int k = 0; k < 3; k++) {
                if (k != yVal) ops += yCount[k];
                if (k != nonYVal) ops += nonYCount[k];
            }
            if (ops < minOps) minOps = ops;
        }
    }

    return minOps;
}