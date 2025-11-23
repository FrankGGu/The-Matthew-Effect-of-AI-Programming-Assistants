int* hitBricks(int** grid, int gridSize, int* gridColSize, int** hits, int hitsSize, int* hitsColSize, int* returnSize) {
    int rows = gridSize, cols = gridColSize[0];
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    int* result = (int*)calloc(hitsSize, sizeof(int));
    *returnSize = hitsSize;

    for (int i = 0; i < hitsSize; i++) {
        int x = hits[i][0], y = hits[i][1];
        if (grid[x][y] == 1) {
            grid[x][y] = 0;
        } else {
            grid[x][y] = -1;
        }
    }

    for (int j = 0; j < cols; j++) {
        if (grid[0][j] == 1) {
            dfs(grid, rows, cols, 0, j);
        }
    }

    for (int i = hitsSize - 1; i >= 0; i--) {
        int x = hits[i][0], y = hits[i][1];
        if (grid[x][y] == -1) {
            continue;
        }
        grid[x][y] = 1;
        if (!isConnectedToTop(grid, rows, cols, x, y)) {
            continue;
        }
        result[i] = dfs(grid, rows, cols, x, y) - 1;
    }

    return result;
}

int dfs(int** grid, int rows, int cols, int i, int j) {
    if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] != 1) {
        return 0;
    }
    grid[i][j] = 2;
    int count = 1;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + directions[k][0];
        int nj = j + directions[k][1];
        count += dfs(grid, rows, cols, ni, nj);
    }
    return count;
}

bool isConnectedToTop(int** grid, int rows, int cols, int i, int j) {
    if (i == 0) return true;
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + directions[k][0];
        int nj = j + directions[k][1];
        if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && grid[ni][nj] == 2) {
            return true;
        }
    }
    return false;
}