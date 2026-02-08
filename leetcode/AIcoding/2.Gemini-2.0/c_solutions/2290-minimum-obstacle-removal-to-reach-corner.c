#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumObstacleRemoval(int** grid, int gridSize, int* gridColSize){
    int m = gridSize;
    int n = gridColSize[0];
    int dist[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    dist[0][0] = 0;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    int queue[m * n * 2];
    int head = 0;
    int tail = 0;

    queue[tail++] = 0;
    queue[tail++] = 0;

    while (head < tail) {
        int x = queue[head++];
        int y = queue[head++];

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                int weight = grid[nx][ny];
                if (dist[x][y] + weight < dist[nx][ny]) {
                    dist[nx][ny] = dist[x][y] + weight;
                    if (weight == 0) {
                        int temp_x = nx;
                        int temp_y = ny;
                        int temp_head = 0;
                        int temp_tail = 0;

                        int new_queue[m * n * 2];
                        new_queue[temp_tail++] = temp_x;
                        new_queue[temp_tail++] = temp_y;

                        for(int k = head; k < tail; k+=2){
                            new_queue[temp_tail++] = queue[k];
                            new_queue[temp_tail++] = queue[k+1];
                        }

                        for(int k = 0; k < temp_tail; k++){
                            queue[k] = new_queue[k];
                        }
                        head = 0;
                        tail = temp_tail;

                    } else {
                        queue[tail++] = nx;
                        queue[tail++] = ny;
                    }
                }
            }
        }
    }

    return dist[m - 1][n - 1];
}