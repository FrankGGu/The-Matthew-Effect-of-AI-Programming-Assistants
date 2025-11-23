int maxIncreaseKeepingSkyline(int** grid, int gridSize, int* gridColSize) {
    int maxRow[gridSize], maxCol[gridSize];
    int totalIncrease = 0;

    for (int i = 0; i < gridSize; i++) {
        maxRow[i] = 0;
        for (int j = 0; j < gridSize; j++) {
            if (grid[i][j] > maxRow[i]) {
                maxRow[i] = grid[i][j];
            }
        }
    }

    for (int j = 0; j < gridSize; j++) {
        maxCol[j] = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > maxCol[j]) {
                maxCol[j] = grid[i][j];
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
            totalIncrease += (maxRow[i] < maxCol[j] ? maxRow[i] : maxCol[j]) - grid[i][j];
        }
    }

    return totalIncrease;
}