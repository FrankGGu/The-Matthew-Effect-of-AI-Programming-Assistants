#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 20

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point p;
    int steps;
} State;

int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

int visited[20][20][20][20];

int bfs(char** grid, int rows, int cols, Point start, Point target, Point box) {
    State q[rows * cols * 4];
    int front = 0, rear = 0;
    memset(visited, 0, sizeof(visited));
    q[rear++] = (State){start, 0};
    visited[start.x][start.y][box.x][box.y] = 1;

    while (front < rear) {
        State curr = q[front++];
        Point p = curr.p;
        int steps = curr.steps;

        if (p.x == target.x && p.y == target.y) return steps;

        for (int d = 0; d < 4; d++) {
            int nx = p.x + dirs[d][0];
            int ny = p.y + dirs[d][1];

            if (nx >= 0 && ny >= 0 && nx < rows && ny < cols && !visited[nx][ny][box.x][box.y]) {
                if (grid[nx][ny] == '.') {
                    visited[nx][ny][box.x][box.y] = 1;
                    q[rear++] = (State){(Point){nx, ny}, steps + 1};
                } else if (grid[nx][ny] == 'B') {
                    int bx = box.x, by = box.y;
                    int bnx = nx + dirs[d][0];
                    int bny = ny + dirs[d][1];
                    if (bnx >= 0 && bny >= 0 && bnx < rows && bny < cols && grid[bnx][bny] == '.' && !visited[nx][ny][bnx][bny]) {
                        visited[nx][ny][bnx][bny] = 1;
                        q[rear++] = (State){(Point){nx, ny}, steps + 1};
                    }
                }
            }
        }
    }

    return -1;
}

int minMovesToBox(char** grid, int rows, int cols, Point* start, Point* target, Point* box) {
    return bfs(grid, rows, cols, *start, *target, *box);
}