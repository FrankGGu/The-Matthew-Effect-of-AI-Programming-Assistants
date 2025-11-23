int maxFish(int** grid, int gridSize, int* gridColSize) {
    int maxFish = 0;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    void dfs(int x, int y, int* count) {
        *count += grid[x][y];
        grid[x][y] = 0; // mark as visited
        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridColSize[0] && grid[newX][newY] > 0) {
                dfs(newX, newY, count);
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] > 0) {
                int count = 0;
                dfs(i, j, &count);
                if (count > maxFish) {
                    maxFish = count;
                }
            }
        }
    }

    return maxFish;
}