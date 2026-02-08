int maxGoldHelper(int** grid, int gridSize, int* gridColSize, int row, int col, int** visited) {
    if (row < 0 || row >= gridSize || col < 0 || col >= *gridColSize || grid[row][col] == 0 || visited[row][col]) {
        return 0;
    }

    visited[row][col] = 1;
    int gold = grid[row][col];

    int maxGold = gold;
    maxGold = fmax(maxGold, gold + maxGoldHelper(grid, gridSize, gridColSize, row + 1, col, visited));
    maxGold = fmax(maxGold, gold + maxGoldHelper(grid, gridSize, gridColSize, row - 1, col, visited));
    maxGold = fmax(maxGold, gold + maxGoldHelper(grid, gridSize, gridColSize, row, col + 1, visited));
    maxGold = fmax(maxGold, gold + maxGoldHelper(grid, gridSize, gridColSize, row, col - 1, visited));

    visited[row][col] = 0;
    return maxGold;
}

int getMaximumGold(int** grid, int gridSize, int* gridColSize) {
    int maxGold = 0;
    int** visited = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        visited[i] = (int*)malloc((*gridColSize) * sizeof(int));
        memset(visited[i], 0, (*gridColSize) * sizeof(int));
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] != 0) {
                maxGold = fmax(maxGold, maxGoldHelper(grid, gridSize, gridColSize, i, j, visited));
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        free(visited[i]);
    }
    free(visited);

    return maxGold;
}