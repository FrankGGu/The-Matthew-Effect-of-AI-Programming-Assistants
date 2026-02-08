#include <stdlib.h>
#include <stdbool.h>

bool dfs(int** grid, int gridSize, int* gridColSize, int x, int y, int targetX, int targetY, bool** visited) {
    if (x == targetX && y == targetY) return true;
    if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[0] || grid[x][y] == 0 || visited[x][y]) return false;

    visited[x][y] = true;

    if (dfs(grid, gridSize, gridColSize, x + 1, y, targetX, targetY, visited)) return true;
    if (dfs(grid, gridSize, gridColSize, x, y + 1, targetX, targetY, visited)) return true;

    return false;
}

bool isPossibleToCutPath(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];

    if (m == 1 && n == 1) return false;

    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)calloc(n, sizeof(bool));
    }

    if (!dfs(grid, m, gridColSize, 0, 0, m - 1, n - 1, visited)) {
        for (int i = 0; i < m; i++) free(visited[i]);
        free(visited);
        return true;
    }

    grid[0][0] = 1;
    grid[m-1][n-1] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    bool secondPath = dfs(grid, m, gridColSize, 0, 0, m - 1, n - 1, visited);

    for (int i = 0; i < m; i++) free(visited[i]);
    free(visited);

    return !secondPath;
}