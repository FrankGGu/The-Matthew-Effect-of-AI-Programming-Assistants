int projectionArea(int** grid, int gridSize, int* gridColSize) {
    int xy_area = 0;
    int yz_area = 0;
    int xz_area = 0;

    for (int i = 0; i < gridSize; i++) {
        int max_in_row = 0;
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > 0) {
                xy_area++;
            }
            if (grid[i][j] > max_in_row) {
                max_in_row = grid[i][j];
            }
        }
        xz_area += max_in_row;
    }

    for (int j = 0; j < gridColSize[0]; j++) {
        int max_in_col = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > max_in_col) {
                max_in_col = grid[i][j];
            }
        }
        yz_area += max_in_col;
    }

    return xy_area + yz_area + xz_area;
}