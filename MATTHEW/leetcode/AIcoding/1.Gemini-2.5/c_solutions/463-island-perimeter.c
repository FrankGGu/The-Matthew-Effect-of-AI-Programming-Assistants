int islandPerimeter(int** grid, int gridSize, int* gridColSize) {
    int perimeter = 0;
    int numRows = gridSize;
    int numCols = gridColSize[0];

    for (int r = 0; r < numRows; r++) {
        for (int c = 0; c < numCols; c++) {
            if (grid[r][c] == 1) {
                // Check top side
                if (r == 0 || grid[r - 1][c] == 0) {
                    perimeter++;
                }
                // Check bottom side
                if (r == numRows - 1 || grid[r + 1][c] == 0) {
                    perimeter++;
                }
                // Check left side
                if (c == 0 || grid[r][c - 1] == 0) {
                    perimeter++;
                }
                // Check right side
                if (c == numCols - 1 || grid[r][c + 1] == 0) {
                    perimeter++;
                }
            }
        }
    }
    return perimeter;
}