#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point pos;
    int dir;
} State;

int minMovesToReachTarget(int** grid, int gridSize, int* gridColSize, int targetX, int targetY) {
    int n = gridSize;
    int directions[4][2] = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
    int rotDirections[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    int visited[4][n][n];
    for (int d = 0; d < 4; d++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                visited[d][i][j] = INT_MAX;
            }
        }
    }

    int dx[] = {-1, 0, 1, 0};
    int dy[] = {0, 1, 0, -1};

    State queue[10000];
    int front = 0, rear = 0;

    for (int d = 0; d < 4; d++) {
        if (grid[0][0] == 0) {
            queue[rear++] = (State){.pos = {0, 0}, .dir = d};
            visited[d][0][0] = 0;
        }
    }

    while (front < rear) {
        State current = queue[front++];
        int x = current.pos.x;
        int y = current.pos.y;
        int dir = current.dir;
        int moves = visited[dir][x][y];

        if (x == targetX && y == targetY) {
            return moves;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] == 0) {
                if (visited[i][nx][ny] > moves + 1) {
                    visited[i][nx][ny] = moves + 1;
                    queue[rear++] = (State){.pos = {nx, ny}, .dir = i};
                }
            }
        }

        int rdir = (dir + 1) % 4;
        int rx = x + rotDirections[rdir][0];
        int ry = y + rotDirections[rdir][1];
        if (rx >= 0 && rx < n && ry >= 0 && ry < n && grid[rx][ry] == 0) {
            if (visited[rdir][rx][ry] > moves + 1) {
                visited[rdir][rx][ry] = moves + 1;
                queue[rear++] = (State){.pos = {rx, ry}, .dir = rdir};
            }
        }
    }

    return -1;
}