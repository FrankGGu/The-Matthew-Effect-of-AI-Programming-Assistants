#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPossibleToCutPath(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) return false;

    bool visited[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    int dx[] = {0, 1};
    int dy[] = {1, 0};

    bool dfs(int x, int y) {
        if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == 0 || visited[x][y]) {
            return false;
        }

        visited[x][y] = true;

        if (x == m - 1 && y == n - 1) {
            return true;
        }

        for (int i = 0; i < 2; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            if (dfs(nx, ny)) {
                return true;
            }
        }

        return false;
    }

    if (!dfs(0, 0)) return true;

    visited[0][0] = false;
    grid[0][0] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    if (!dfs(0, 0)) return true;

    grid[0][0] = 1;

    visited[m - 1][n - 1] = false;
    grid[m - 1][n - 1] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    if (!dfs(0, 0)) return true;

    grid[m - 1][n - 1] = 1;

    return false;
}