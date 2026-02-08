int closedIsland(int** grid, int gridSize, int* gridColSize) {
    int closed_islands = 0;
    int rows = gridSize, cols = *gridColSize;

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols) return;
        if (grid[r][c] == 1) return;
        grid[r][c] = 1;
        dfs(r - 1, c);
        dfs(r + 1, c);
        dfs(r, c - 1);
        dfs(r, c + 1);
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                int boundary = 1;
                if (i == 0 || i == rows - 1 || j == 0 || j == cols - 1) boundary = 0;
                dfs(i, j);
                if (boundary) closed_islands++;
            }
        }
    }
    return closed_islands;
}