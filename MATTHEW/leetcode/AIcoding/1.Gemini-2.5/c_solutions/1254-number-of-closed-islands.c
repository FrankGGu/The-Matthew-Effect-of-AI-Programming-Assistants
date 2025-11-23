void dfs(int** grid, int r, int c, int rows, int cols) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 1) {
        return;
    }

    grid[r][c] = 1; // Mark as visited (turned into water)

    dfs(grid, r + 1, c, rows, cols);
    dfs(grid, r - 1, c, rows, cols);
    dfs(grid, r, c + 1, rows, cols);
    dfs(grid, r, c - 1, rows, cols);
}

int closedIsland(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    // Phase 1: Sink all land connected to the boundary
    // Check top and bottom rows
    for (int c = 0; c < cols; c++) {
        if (grid[0][c] == 0) {
            dfs(grid, 0, c, rows, cols);
        }
        if (grid[rows - 1][c] == 0) {
            dfs(grid, rows - 1, c, rows, cols);
        }
    }

    // Check left and right columns
    for (int r = 0; r < rows; r++) {
        if (grid[r][0] == 0) {
            dfs(grid, r, 0, rows, cols);
        }
        if (grid[r][cols - 1] == 0) {
            dfs(grid, r, cols - 1, rows, cols);
        }
    }

    // Phase 2: Count remaining islands (which must be closed)
    int closedIslands = 0;
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid[r][c] == 0) {
                closedIslands++;
                dfs(grid, r, c, rows, cols); // Sink this closed island
            }
        }
    }

    return closedIslands;
}