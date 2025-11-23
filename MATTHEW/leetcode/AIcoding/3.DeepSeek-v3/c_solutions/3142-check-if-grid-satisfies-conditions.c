bool satisfiesConditions(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = *gridColSize;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i < m - 1 && grid[i][j] != grid[i + 1][j]) {
                return false;
            }
            if (j < n - 1 && grid[i][j] == grid[i][j + 1]) {
                return false;
            }
        }
    }

    return true;
}