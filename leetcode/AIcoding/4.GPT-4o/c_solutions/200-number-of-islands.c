int numIslands(char** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || *gridColSize == 0) return 0;
    int count = 0;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    void dfs(int r, int c) {
        grid[r][c] = '0';
        for (int i = 0; i < 4; i++) {
            int newRow = r + directions[i][0];
            int newCol = c + directions[i][1];
            if (newRow >= 0 && newRow < gridSize && newCol >= 0 && newCol < *gridColSize && grid[newRow][newCol] == '1') {
                dfs(newRow, newCol);
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == '1') {
                count++;
                dfs(i, j);
            }
        }
    }
    return count;
}