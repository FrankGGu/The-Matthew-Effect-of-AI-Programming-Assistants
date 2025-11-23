int minFlips(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int flips = 0;

    for (int i = 0; i < n / 2; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] != grid[n - 1 - i][j]) {
                flips++;
            }
        }
    }

    for (int j = 0; j < m / 2; j++) {
        for (int i = 0; i < n; i++) {
            if (grid[i][j] != grid[i][m - 1 - j]) {
                flips++;
            }
        }
    }

    return flips;
}