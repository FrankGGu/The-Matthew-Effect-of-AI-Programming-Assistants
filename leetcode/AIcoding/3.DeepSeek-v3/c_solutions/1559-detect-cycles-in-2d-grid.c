int dx[4] = {0, 1, 0, -1};
int dy[4] = {1, 0, -1, 0};

bool dfs(char** grid, int gridSize, int* gridColSize, int x, int y, int px, int py, char target) {
    grid[x][y] = target - 'a' + 'A';

    for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];

        if (nx < 0 || nx >= gridSize || ny < 0 || ny >= gridColSize[0]) {
            continue;
        }

        if (nx == px && ny == py) {
            continue;
        }

        if (grid[nx][ny] == target) {
            if (dfs(grid, gridSize, gridColSize, nx, ny, x, y, target)) {
                return true;
            }
        } else if (grid[nx][ny] == target - 'a' + 'A') {
            return true;
        }
    }

    return false;
}

bool containsCycle(char** grid, int gridSize, int* gridColSize) {
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] >= 'a' && grid[i][j] <= 'z') {
                if (dfs(grid, gridSize, gridColSize, i, j, -1, -1, grid[i][j])) {
                    return true;
                }
            }
        }
    }
    return false;
}