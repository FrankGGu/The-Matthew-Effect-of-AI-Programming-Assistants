int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    int maxArea = 0;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    void dfs(int x, int y, int* area) {
        if (x < 0 || x >= gridSize || y < 0 || y >= *gridColSize || grid[x][y] == 0) return;
        grid[x][y] = 0;
        (*area)++;
        for (int i = 0; i < 4; i++) {
            dfs(x + directions[i][0], y + directions[i][1], area);
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 1) {
                int area = 0;
                dfs(i, j, &area);
                if (area > maxArea) maxArea = area;
            }
        }
    }

    return maxArea;
}