int dfs(int** grid, int r, int c, int R, int C) {
    if (r < 0 || r >= R || c < 0 || c >= C || grid[r][c] == 0) {
        return 0;
    }

    grid[r][c] = 0;
    int currentArea = 1;

    currentArea += dfs(grid, r + 1, c, R, C);
    currentArea += dfs(grid, r - 1, c, R, C);
    currentArea += dfs(grid, r, c + 1, R, C);
    currentArea += dfs(grid, r, c - 1, R, C);

    return currentArea;
}

int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int R = gridSize;
    int C = gridColSize[0];
    int maxArea = 0;

    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            if (grid[i][j] == 1) {
                int currentIslandArea = dfs(grid, i, j, R, C);
                if (currentIslandArea > maxArea) {
                    maxArea = currentIslandArea;
                }
            }
        }
    }

    return maxArea;
}