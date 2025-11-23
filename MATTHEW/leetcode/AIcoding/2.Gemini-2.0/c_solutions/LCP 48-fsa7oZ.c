#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};

bool dfs(int x, int y, int targetX, int targetY, int limit, bool** visited, int m, int n, int* forbiddenCol, int forbiddenColSize) {
    if (x < 0 || x >= m || y < 0 || y >= n || visited[x][y]) {
        return false;
    }

    if (x == targetX && y == targetY) {
        return true;
    }

    bool isForbidden = false;
    for (int i = 0; i < forbiddenColSize; i++) {
        if (x == limit && y == forbiddenCol[i]) {
            isForbidden = true;
            break;
        }
    }
    if (isForbidden) return false;

    visited[x][y] = true;

    for (int i = 0; i < 4; i++) {
        int newX = x + dx[i];
        int newY = y + dy[i];
        if (dfs(newX, newY, targetX, targetY, limit, visited, m, n, forbiddenCol, forbiddenColSize)) {
            return true;
        }
    }

    return false;
}

bool isReachable(int m, int n, int startX, int startY, int targetX, int targetY, int limit, int* forbiddenCol, int forbiddenColSize) {
    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)malloc(n * sizeof(bool));
        for (int j = 0; j < n; j++) {
            visited[i][j] = false;
        }
    }

    bool result = dfs(startX, startY, targetX, targetY, limit, visited, m, n, forbiddenCol, forbiddenColSize);

    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);

    return result;
}