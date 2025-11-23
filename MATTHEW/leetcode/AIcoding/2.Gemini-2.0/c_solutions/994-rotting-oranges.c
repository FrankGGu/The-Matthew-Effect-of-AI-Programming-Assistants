#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int fresh_count = 0;
    int time = 0;

    int q_size = 0;
    int** queue = (int**)malloc(rows * cols * sizeof(int*));
    for (int i = 0; i < rows * cols; i++) {
        queue[i] = (int*)malloc(2 * sizeof(int));
    }
    int head = 0;
    int tail = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                fresh_count++;
            } else if (grid[i][j] == 2) {
                queue[tail][0] = i;
                queue[tail][1] = j;
                tail++;
                q_size++;
            }
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (q_size > 0 && fresh_count > 0) {
        int curr_q_size = q_size;
        time++;

        for (int i = 0; i < curr_q_size; i++) {
            int row = queue[head][0];
            int col = queue[head][1];
            head++;
            q_size--;

            for (int j = 0; j < 4; j++) {
                int new_row = row + dx[j];
                int new_col = col + dy[j];

                if (new_row >= 0 && new_row < rows && new_col >= 0 && new_col < cols && grid[new_row][new_col] == 1) {
                    grid[new_row][new_col] = 2;
                    fresh_count--;
                    queue[tail][0] = new_row;
                    queue[tail][1] = new_col;
                    tail++;
                    q_size++;
                }
            }
        }
    }

    for (int i = 0; i < rows * cols; i++) {
        free(queue[i]);
    }
    free(queue);

    if (fresh_count > 0) {
        return -1;
    } else {
        return time;
    }
}