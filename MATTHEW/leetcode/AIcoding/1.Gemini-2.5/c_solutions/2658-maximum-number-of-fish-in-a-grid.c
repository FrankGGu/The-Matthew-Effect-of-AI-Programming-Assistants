void dfs(int** grid, int r, int c, int rows, int cols, int* currentSum) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == -1) {
        return;
    }

    *currentSum += grid[r][c];
    grid[r][c] = -1; // Mark as visited

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    for (int i = 0; i < 4; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];
        dfs(grid, nr, nc, rows, cols, currentSum);
    }
}

int findMaxFish(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    if (rows == 0) {
        return 0;
    }
    int cols = gridColSize[0];
    if (cols == 0) {
        return 0;
    }

    int maxFish = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid[r][c] != -1) { // If it's a water cell (0 or >0 fish) and not visited
                int currentFish = 0;
                dfs(grid, r, c, rows, cols, &currentFish);
                if (currentFish > maxFish) {
                    maxFish = currentFish;
                }
            }
        }
    }

    return maxFish;
}