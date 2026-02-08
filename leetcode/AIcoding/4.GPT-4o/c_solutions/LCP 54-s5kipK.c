int captureTerritory(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize, cols = gridColSize[0];
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int captured = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                for (int d = 0; d < 4; d++) {
                    int ni = i + directions[d][0], nj = j + directions[d][1];
                    if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && grid[ni][nj] == 0) {
                        captured++;
                        grid[ni][nj] = 2;
                    }
                }
            }
        }
    }

    return captured;
}