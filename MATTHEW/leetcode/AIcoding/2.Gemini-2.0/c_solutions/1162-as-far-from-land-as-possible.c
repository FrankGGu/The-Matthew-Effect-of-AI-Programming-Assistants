#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDistance(int** grid, int gridSize, int* gridColSize){
    int n = gridSize;
    int q[n * n][2];
    int head = 0, tail = 0;
    int visited[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                q[tail][0] = i;
                q[tail][1] = j;
                tail++;
                visited[i][j] = 1;
            }
        }
    }

    if (tail == 0 || tail == n * n) {
        return -1;
    }

    int dist = -1;
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (head < tail) {
        int size = tail - head;
        dist++;
        for (int i = 0; i < size; i++) {
            int x = q[head][0];
            int y = q[head][1];
            head++;

            for (int j = 0; j < 4; j++) {
                int nx = x + dx[j];
                int ny = y + dy[j];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && visited[nx][ny] == 0) {
                    q[tail][0] = nx;
                    q[tail][1] = ny;
                    tail++;
                    visited[nx][ny] = 1;
                }
            }
        }
    }

    return dist;
}