int projectionArea(int** grid, int gridSize, int* gridColSize) {
    int area = 0;

    for (int i = 0; i < gridSize; i++) {
        int maxRow = 0;
        int maxCol = 0;
        for (int j = 0; j < gridSize; j++) {
            if (grid[i][j] > 0) area++;
            if (grid[i][j] > maxRow) maxRow = grid[i][j];
            if (grid[j][i] > maxCol) maxCol = grid[j][i];
        }
        area += maxRow + maxCol;
    }

    return area;
}