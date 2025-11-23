int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

int dfs(int** grid, int gridSize, int* gridColSize, int row, int col) {
    if (row < 0 || row >= gridSize || col < 0 || col >= gridColSize[0] || grid[row][col] == 0) {
        return 0;
    }

    int currentGold = grid[row][col];
    grid[row][col] = 0;

    int maxGold = 0;
    for (int i = 0; i < 4; i++) {
        int newRow = row + directions[i][0];
        int newCol = col + directions[i][1];
        maxGold = fmax(maxGold, dfs(grid, gridSize, gridColSize, newRow, newCol));
    }

    grid[row][col] = currentGold;
    return currentGold + maxGold;
}

int getMaximumGold(int** grid, int gridSize, int* gridColSize) {
    int maxGold = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] != 0) {
                maxGold = fmax(maxGold, dfs(grid, gridSize, gridColSize, i, j));
            }
        }
    }

    return maxGold;
}