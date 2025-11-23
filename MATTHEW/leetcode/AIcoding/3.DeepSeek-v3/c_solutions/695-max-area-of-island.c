int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize) {
    int maxArea = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                int area = dfs(grid, gridSize, gridColSize, i, j);
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    return maxArea;
}

int dfs(int** grid, int gridSize, int* gridColSize, int i, int j) {
    if (i < 0 || i >= gridSize || j < 0 || j >= gridColSize[i] || grid[i][j] != 1) {
        return 0;
    }

    grid[i][j] = 0;

    int area = 1;
    area += dfs(grid, gridSize, gridColSize, i + 1, j);
    area += dfs(grid, gridSize, gridColSize, i - 1, j);
    area += dfs(grid, gridSize, gridColSize, i, j + 1);
    area += dfs(grid, gridSize, gridColSize, i, j - 1);

    return area;
}