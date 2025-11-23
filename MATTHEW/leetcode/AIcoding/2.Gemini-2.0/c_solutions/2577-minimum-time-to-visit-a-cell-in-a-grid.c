#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1000

typedef struct {
    int row;
    int col;
    int time;
} QueueNode;

int minimumTime(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    if (grid[0][1] > 1 && grid[1][0] > 1) {
        return -1;
    }

    int dist[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    dist[0][0] = 0;

    QueueNode queue[MAX_SIZE * MAX_SIZE];
    int front = 0;
    int rear = 0;

    queue[rear++] = (QueueNode){0, 0, 0};

    int dr[] = {0, 0, 1, -1};
    int dc[] = {1, -1, 0, 0};

    while (front < rear) {
        QueueNode curr = queue[front++];
        int r = curr.row;
        int c = curr.col;
        int t = curr.time;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                int wait_time = (grid[nr][nc] > t + 1) ? (grid[nr][nc] - (t + 1)) : 0;
                int new_time = t + 1 + wait_time;

                if (new_time < dist[nr][nc]) {
                    dist[nr][nc] = new_time;
                    queue[rear++] = (QueueNode){nr, nc, new_time};
                }
            }
        }
    }

    if (dist[rows - 1][cols - 1] == INT_MAX) {
        return -1;
    }

    return dist[rows - 1][cols - 1];
}