#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VISITED 20000

typedef struct {
    int x;
    int y;
} Point;

int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};

bool is_blocked(int x, int y, int** blocked, int blockedSize, int* blockedColSize) {
    for (int i = 0; i < blockedSize; i++) {
        if (blocked[i][0] == x && blocked[i][1] == y) {
            return true;
        }
    }
    return false;
}

bool is_valid(int x, int y, int n) {
    return x >= 0 && x < n && y >= 0 && y < n;
}

bool escapeMaze(int** blocked, int blockedSize, int* blockedColSize, int* source, int sourceSize, int* target, int targetSize, int n) {

    bool bfs(int sx, int sy, int tx, int ty) {
        bool visited[1000000] = {false};

        Point queue[MAX_VISITED + 1];
        int head = 0, tail = 0;

        queue[tail].x = sx;
        queue[tail].y = sy;
        tail++;
        visited[((long long)sx * n + sy)] = true;

        int count = 0;

        while (head < tail && count < MAX_VISITED) {
            Point curr = queue[head];
            head++;
            count++;

            if (curr.x == tx && curr.y == ty) {
                return true;
            }

            for (int i = 0; i < 4; i++) {
                int nx = curr.x + dx[i];
                int ny = curr.y + dy[i];

                if (is_valid(nx, ny, n) && !is_blocked(nx, ny, blocked, blockedSize, blockedColSize) && !visited[((long long)nx * n + ny)]) {
                    queue[tail].x = nx;
                    queue[tail].y = ny;
                    tail++;
                    visited[((long long)nx * n + ny)] = true;
                }
            }
        }

        return false;
    }

    return bfs(source[0], source[1], target[0], target[1]) && bfs(target[0], target[1], source[0], source[1]);
}