int minDays(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int countIslands(int** grid, int gridSize, int* gridColSize) {
        int count = 0;
        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < gridColSize[i]; j++) {
                if (grid[i][j] == 1) {
                    count++;
                    // DFS to mark all connected land
                    void dfs(int x, int y) {
                        grid[x][y] = 0;
                        for (int d = 0; d < 4; d++) {
                            int newX = x + directions[d][0];
                            int newY = y + directions[d][1];
                            if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridColSize[newX] && grid[newX][newY] == 1) {
                                dfs(newX, newY);
                            }
                        }
                    }
                    dfs(i, j);
                }
            }
        }
        return count;
    }

    int islands = countIslands(grid, gridSize, gridColSize);
    if (islands == 0) return 0;
    if (islands == 1) return 1;

    return 2;
}