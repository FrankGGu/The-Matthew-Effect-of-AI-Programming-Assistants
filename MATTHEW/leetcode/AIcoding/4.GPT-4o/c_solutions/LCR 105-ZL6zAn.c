int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    int maxArea = 0;

    void dfs(int x, int y, int* area) {
        if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[0] || grid[x][y] == 0) return;
        grid[x][y] = 0;
        (*area)++;
        dfs(x + 1, y, area);
        dfs(x - 1, y, area);
        dfs(x, y + 1, area);
        dfs(x, y - 1, area);
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == 1) {
                int area = 0;
                dfs(i, j, &area);
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    return maxArea;
}