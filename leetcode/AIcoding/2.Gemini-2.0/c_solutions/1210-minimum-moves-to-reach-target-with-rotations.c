#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y, dir, moves;
} State;

int minimumMoves(int** grid, int gridSize, int* gridColSize, int targetX, int targetY) {
    int n = gridSize;
    bool visited[n][n][2];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j][0] = false;
            visited[i][j][1] = false;
        }
    }

    State queue[n * n * 2];
    int head = 0, tail = 0;
    queue[tail++] = (State){0, 0, 0, 0};
    visited[0][0][0] = true;

    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    while (head < tail) {
        State curr = queue[head++];

        if (curr.x == targetX && curr.y == targetY && curr.dir == 0) {
            return curr.moves;
        }

        // Move forward
        int x1 = curr.x + dx[curr.dir];
        int y1 = curr.y + dy[curr.dir];
        int x2 = x1 + dx[curr.dir];
        int y2 = y1 + dy[curr.dir];

        if (x2 < n && x2 >= 0 && y2 < n && y2 >= 0 && grid[x1][y1] == 0 && grid[x2][y2] == 0 && !visited[x1][y1][curr.dir]) {
            queue[tail++] = (State){x1, y1, curr.dir, curr.moves + 1};
            visited[x1][y1][curr.dir] = true;
        }

        // Rotate
        if (curr.dir == 0) {
            if (curr.x + 1 < n && grid[curr.x + 1][curr.y] == 0 && grid[curr.x + 1][curr.y + 1] == 0) {
                if (!visited[curr.x][curr.y][1]) {
                    queue[tail++] = (State){curr.x, curr.y, 1, curr.moves + 1};
                    visited[curr.x][curr.y][1] = true;
                }
            }
        } else {
            if (curr.y + 1 < n && grid[curr.x][curr.y + 1] == 0 && grid[curr.x + 1][curr.y + 1] == 0) {
                if (!visited[curr.x][curr.y][0]) {
                    queue[tail++] = (State){curr.x, curr.y, 0, curr.moves + 1};
                    visited[curr.x][curr.y][0] = true;
                }
            }
        }
    }

    return -1;
}