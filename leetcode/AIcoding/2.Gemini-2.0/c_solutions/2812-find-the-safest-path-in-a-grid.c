#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 400
#define INF 1e9

int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int bfs(int n, int m, int** grid, int** dist) {
    int i, j, x, y, nx, ny;
    int qx[MAX_SIZE * MAX_SIZE], qy[MAX_SIZE * MAX_SIZE];
    int head = 0, tail = 0;

    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            dist[i][j] = INF;
        }
    }

    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                dist[i][j] = 0;
                qx[tail] = i;
                qy[tail] = j;
                tail++;
            }
        }
    }

    while (head < tail) {
        x = qx[head];
        y = qy[head];
        head++;

        for (i = 0; i < 4; i++) {
            nx = x + dx[i];
            ny = y + dy[i];

            if (nx >= 0 && nx < n && ny >= 0 && ny < m && dist[nx][ny] == INF) {
                dist[nx][ny] = dist[x][y] + 1;
                qx[tail] = nx;
                qy[tail] = ny;
                tail++;
            }
        }
    }

    return 0;
}

bool check(int n, int m, int** dist, int mid) {
    int i, j, x, y, nx, ny;
    int qx[MAX_SIZE * MAX_SIZE], qy[MAX_SIZE * MAX_SIZE];
    int head = 0, tail = 0;
    bool visited[MAX_SIZE][MAX_SIZE];

    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            visited[i][j] = false;
        }
    }

    if (dist[0][0] < mid) return false;

    qx[tail] = 0;
    qy[tail] = 0;
    tail++;
    visited[0][0] = true;

    while (head < tail) {
        x = qx[head];
        y = qy[head];
        head++;

        if (x == n - 1 && y == m - 1) return true;

        for (i = 0; i < 4; i++) {
            nx = x + dx[i];
            ny = y + dy[i];

            if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny] && dist[nx][ny] >= mid) {
                visited[nx][ny] = true;
                qx[tail] = nx;
                qy[tail] = ny;
                tail++;
            }
        }
    }

    return false;
}

int maximumSafenessFactor(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int i, j;

    int** dist = (int**)malloc(n * sizeof(int*));
    for (i = 0; i < n; i++) {
        dist[i] = (int*)malloc(m * sizeof(int));
    }

    bfs(n, m, grid, dist);

    int left = 0, right = min(dist[0][0], dist[n - 1][m - 1]);
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(n, m, dist, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    for (i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);

    return ans;
}