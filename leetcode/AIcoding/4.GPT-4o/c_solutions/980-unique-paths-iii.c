int uniquePathsIII(int** grid, int gridSize, int* gridColSize) {
    int startX, startY, endX, endY, emptyCount = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 1) {
                startX = i; startY = j;
            } else if (grid[i][j] == 2) {
                endX = i; endY = j;
            } else if (grid[i][j] == 0) {
                emptyCount++;
            }
        }
    }

    int dfs(int x, int y, int count) {
        if (x < 0 || y < 0 || x >= gridSize || y >= *gridColSize || grid[x][y] == -1) return 0;
        if (x == endX && y == endY) return count == emptyCount ? 1 : 0;

        int temp = grid[x][y];
        grid[x][y] = -1; // mark as visited
        int pathCount = dfs(x + 1, y, count + (temp == 0)) +
                        dfs(x - 1, y, count + (temp == 0)) +
                        dfs(x, y + 1, count + (temp == 0)) +
                        dfs(x, y - 1, count + (temp == 0));
        grid[x][y] = temp; // unmark

        return pathCount;
    }

    return dfs(startX, startY, 0);
}