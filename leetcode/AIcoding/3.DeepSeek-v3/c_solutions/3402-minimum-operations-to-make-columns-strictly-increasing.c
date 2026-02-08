int minOperations(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int operations = 0;

    for (int j = 0; j < cols; j++) {
        for (int i = 1; i < rows; i++) {
            if (grid[i][j] <= grid[i-1][j]) {
                operations += grid[i-1][j] - grid[i][j] + 1;
                grid[i][j] = grid[i-1][j] + 1;
            }
        }
    }

    return operations;
}