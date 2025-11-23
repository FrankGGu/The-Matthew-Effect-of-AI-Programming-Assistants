bool hasCycle(char** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    bool visited[50][50] = {false};
    int rows = gridSize, cols = *gridColSize;

    bool dfs(int x, int y, int px, int py, char target) {
        if (x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] != target) return false;
        if (visited[x][y]) return true;
        visited[x][y] = true;

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX == px && newY == py) continue;
            if (dfs(newX, newY, x, y, target)) return true;
        }
        return false;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (!visited[i][j] && dfs(i, j, -1, -1, grid[i][j])) {
                return true;
            }
        }
    }
    return false;
}