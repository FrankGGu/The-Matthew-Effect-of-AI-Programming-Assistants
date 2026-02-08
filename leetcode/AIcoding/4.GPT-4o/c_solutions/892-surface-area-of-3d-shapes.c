int surfaceArea(int** grid, int gridSize, int* gridColSize) {
    int area = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] > 0) {
                area += 2; // Top and bottom
                area += 4 * grid[i][j]; // 4 sides
                if (i > 0) area -= fmin(grid[i][j], grid[i - 1][j]) * 2; // Front
                if (j > 0) area -= fmin(grid[i][j], grid[i][j - 1]) * 2; // Left
                if (i < gridSize - 1) area -= fmin(grid[i][j], grid[i + 1][j]) * 2; // Back
                if (j < gridColSize[0] - 1) area -= fmin(grid[i][j], grid[i][j + 1]) * 2; // Right
            }
        }
    }
    return area;
}