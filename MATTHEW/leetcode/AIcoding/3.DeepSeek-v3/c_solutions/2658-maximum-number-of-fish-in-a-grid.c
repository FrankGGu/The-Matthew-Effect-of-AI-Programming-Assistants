int dfs(int** grid, int gridSize, int* gridColSize, int r, int c) {
    if (r < 0 || r >= gridSize || c < 0 || c >= gridColSize[0] || grid[r][c] == 0) {
        return 0;
    }

    int fish = grid[r][c];
    grid[r][c] = 0;

    fish += dfs(grid, gridSize, gridColSize, r + 1, c);
    fish += dfs(grid, gridSize, gridColSize, r - 1, c);
    fish += dfs(grid, gridSize, gridColSize, r, c + 1);
    fish += dfs(grid, gridSize, gridColSize, r, c - 1);

    return fish;
}

int findMaxFish(int** grid, int gridSize, int* gridColSize) {
    int maxFish = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > 0) {
                int currentFish = dfs(grid, gridSize, gridColSize, i, j);
                if (currentFish > maxFish) {
                    maxFish = currentFish;
                }
            }
        }
    }

    return maxFish;
}