#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int is_valid(int x, int y, int n) {
    return x >= 0 && x < n && y >= 0 && y < n;
}

int snakeInMatrix(int n, int** blocked, int blockedSize, int* blockedColSize) {
    int** visited = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        visited[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            visited[i][j] = 0;
        }
    }

    for (int i = 0; i < blockedSize; i++) {
        visited[blocked[i][0]][blocked[i][1]] = 1;
    }

    if (visited[0][0] == 1 || visited[n - 1][n - 1] == 1) {
        for (int i = 0; i < n; i++) {
            free(visited[i]);
        }
        free(visited);
        return 0;
    }

    Point queue[n * n];
    int head = 0, tail = 0;
    queue[tail].x = 0;
    queue[tail].y = 0;
    tail++;
    visited[0][0] = 1;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (head < tail) {
        Point curr = queue[head++];
        if (curr.x == n - 1 && curr.y == n - 1) {
            for (int i = 0; i < n; i++) {
                free(visited[i]);
            }
            free(visited);
            return 1;
        }

        for (int i = 0; i < 4; i++) {
            int next_x = curr.x + dx[i];
            int next_y = curr.y + dy[i];

            if (is_valid(next_x, next_y, n) && visited[next_x][next_y] == 0) {
                queue[tail].x = next_x;
                queue[tail].y = next_y;
                tail++;
                visited[next_x][next_y] = 1;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(visited[i]);
    }
    free(visited);
    return 0;
}