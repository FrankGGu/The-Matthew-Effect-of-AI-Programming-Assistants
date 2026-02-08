typedef struct {
    int x, y;
} Point;

int isSafe(int** grid, int x, int y, int n) {
    return (x >= 0 && x < n && y >= 0 && y < n && grid[x][y] == 0);
}

int dfs(int** grid, int** visited, int x, int y, int n) {
    if (x == n - 1 && y == n - 1) return 1;
    visited[x][y] = 1;

    int dir[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    for (int i = 0; i < 4; i++) {
        int newX = x + dir[i][0];
        int newY = y + dir[i][1];
        if (isSafe(grid, newX, newY, n) && !visited[newX][newY]) {
            if (dfs(grid, visited, newX, newY, n)) return 1;
        }
    }

    return 0;
}

int isPathPossible(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] == 1 || grid[gridSize - 1][gridSize - 1] == 1) return 0;

    int** visited = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        visited[i] = (int*)calloc(gridSize, sizeof(int));
    }

    int result = dfs(grid, visited, 0, 0, gridSize);

    for (int i = 0; i < gridSize; i++) {
        free(visited[i]);
    }
    free(visited);

    return result;
}