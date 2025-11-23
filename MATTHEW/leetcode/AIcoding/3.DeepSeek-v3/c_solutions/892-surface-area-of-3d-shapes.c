int surfaceArea(int** grid, int gridSize, int* gridColSize) {
    int area = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
            if (grid[i][j] > 0) {
                area += 2;
            }

            if (i == 0) {
                area += grid[i][j];
            } else {
                area += fmax(0, grid[i][j] - grid[i-1][j]);
            }

            if (i == gridSize - 1) {
                area += grid[i][j];
            } else {
                area += fmax(0, grid[i][j] - grid[i+1][j]);
            }

            if (j == 0) {
                area += grid[i][j];
            } else {
                area += fmax(0, grid[i][j] - grid[i][j-1]);
            }

            if (j == gridSize - 1) {
                area += grid[i][j];
            } else {
                area += fmax(0, grid[i][j] - grid[i][j+1]);
            }
        }
    }

    return area;
}