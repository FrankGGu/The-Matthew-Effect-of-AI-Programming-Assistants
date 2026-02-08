int longestSpecialPath(int** grid, int gridSize, int* gridColSize) {
    int maxLength = 0;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int visited[gridSize][gridColSize[0]];

    memset(visited, 0, sizeof(visited));

    void dfs(int x, int y, int length) {
        if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[0] || visited[x][y]) return;
        visited[x][y] = 1;
        maxLength = fmax(maxLength, length);

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridColSize[0] && grid[newX][newY] > grid[x][y]) {
                dfs(newX, newY, length + 1);
            }
        }

        visited[x][y] = 0;
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            dfs(i, j, 1);
        }
    }

    return maxLength;
}