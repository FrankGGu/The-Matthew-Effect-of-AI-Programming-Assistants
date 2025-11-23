int projectionArea(int** grid, int gridSize, int* gridColSize) {
    int xy = 0, xz = 0, yz = 0;
    for (int i = 0; i < gridSize; i++) {
        int maxRow = 0, maxCol = 0;
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] > 0) xy++;
            maxRow = maxRow > grid[i][j] ? maxRow : grid[i][j];
            maxCol = maxCol > grid[j][i] ? maxCol : grid[j][i];
        }
        xz += maxRow;
        yz += maxCol;
    }
    return xy + xz + yz;
}