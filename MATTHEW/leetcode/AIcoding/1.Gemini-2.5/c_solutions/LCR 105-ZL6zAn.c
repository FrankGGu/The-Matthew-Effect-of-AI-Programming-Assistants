int dfs(int** grid, int r, int c, int rows, int cols) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
        return 0;
    }

    grid[r][c] = 0; // Mark as visited (sink the island part)
    int area = 1;

    area += dfs(grid, r + 1, c, rows, cols);
    area += dfs(grid, r - 1, c, rows, cols);
    area += dfs(grid, r, c + 1, rows, cols);
    area += dfs(grid, r, c - 1, rows, cols);

    return area;
}

int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int rows = gridSize;
    int cols = gridColSize[0];
    int max_area = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid[r][c] == 1) {
                int current_island_area = dfs(grid, r, c, rows, cols);
                if (current_island_area > max_area) {
                    max_area = current_island_area;
                }
            }
        }
    }

    return max_area;
}