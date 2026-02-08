#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y, keys, steps;
} State;

int shortestPathAllKeys(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = *gridColSize;
    int startX, startY, maxKeys = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '@') {
                startX = i;
                startY = j;
            } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                maxKeys = (maxKeys | (1 << (grid[i][j] - 'a')));
            }
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    int visited[m][n][64];
    memset(visited, 0, sizeof(visited));

    State start = {startX, startY, 0, 0};
    visited[startX][startY][0] = 1;

    State queue[m * n * 64];
    int head = 0, tail = 0;
    queue[tail++] = start;

    while (head < tail) {
        State curr = queue[head++];

        if (curr.keys == maxKeys) {
            return curr.steps;
        }

        for (int i = 0; i < 4; i++) {
            int nx = curr.x + dx[i];
            int ny = curr.y + dy[i];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != '#') {
                int newKeys = curr.keys;
                if (grid[nx][ny] >= 'a' && grid[nx][ny] <= 'f') {
                    newKeys = (newKeys | (1 << (grid[nx][ny] - 'a')));
                } else if (grid[nx][ny] >= 'A' && grid[nx][ny] <= 'F') {
                    if (!(curr.keys & (1 << (grid[nx][ny] - 'A')))) {
                        continue;
                    }
                }

                if (!visited[nx][ny][newKeys]) {
                    visited[nx][ny][newKeys] = 1;
                    State next = {nx, ny, newKeys, curr.steps + 1};
                    queue[tail++] = next;
                }
            }
        }
    }

    return -1;
}