int minFlips(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize, m = *gridColSize;
    int flips = 0;
    for (int i = 0; i < n / 2; ++i) {
        for (int j = 0; j < m; ++j) {
            flips += grid[i][j] != grid[n - i - 1][m - j - 1];
        }
    }
    if (n % 2 == 1) {
        for (int j = 0; j < m / 2; ++j) {
            flips += grid[n / 2][j] != grid[n / 2][m - j - 1];
        }
    }
    return flips;
}