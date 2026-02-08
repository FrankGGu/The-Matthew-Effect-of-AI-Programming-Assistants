int minPathSum(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // Initialize first row
    for (int j = 1; j < n; j++) {
        grid[0][j] += grid[0][j - 1];
    }

    // Initialize first column
    for (int i = 1; i < m; i++) {
        grid[i][0] += grid[i - 1][0];
    }

    // Fill the rest of the grid using dynamic programming
    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            grid[i][j] += (grid[i - 1][j] < grid[i][j - 1] ? grid[i - 1][j] : grid[i][j - 1]);
        }
    }

    // The bottom-right cell contains the minimum path sum
    return grid[m - 1][n - 1];
}