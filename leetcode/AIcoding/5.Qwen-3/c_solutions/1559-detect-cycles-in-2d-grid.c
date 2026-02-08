#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool hasCycle(char** grid, int rows, int cols) {
    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    int dx[] = {-1, 0, 1, 0};
    int dy[] = {0, 1, 0, -1};

    bool dfs(int x, int y, int px, int py, char c, bool** visited) {
        if (x < 0 || y < 0 || x >= rows || y >= cols) return false;
        if (visited[x][y]) return true;
        if (grid[x][y] != c) return false;

        visited[x][y] = true;
        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            if (nx != px || ny != py) {
                if (dfs(nx, ny, x, y, c, visited)) {
                    return true;
                }
            }
        }
        return false;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (!visited[i][j]) {
                if (dfs(i, j, -1, -1, grid[i][j], visited)) {
                    for (int k = 0; k < rows; k++) {
                        free(visited[k]);
                    }
                    free(visited);
                    return true;
                }
            }
        }
    }

    for (int k = 0; k < rows; k++) {
        free(visited[k]);
    }
    free(visited);
    return false;
}