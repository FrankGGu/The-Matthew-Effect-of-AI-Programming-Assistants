int minFlips(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    if (rows == 0) {
        return 0;
    }
    int cols = gridColSize[0];
    if (cols == 0) {
        return 0;
    }

    int flips = 0;

    for (int r = 0; r < rows; ++r) {
        for (int c = 0; c < cols; ++c) {
            if (grid[r][c] != grid[rows - 1 - r][cols - 1 - c]) {
                flips++;
            }
        }
    }

    return flips / 2;
}