#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumVisitedCells(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = -1;
        }
    }

    dist[0][0] = 1;
    int queue_row[rows * cols];
    int queue_col[rows * cols];
    int head = 0;
    int tail = 0;
    queue_row[tail] = 0;
    queue_col[tail] = 0;
    tail++;

    while (head < tail) {
        int curr_row = queue_row[head];
        int curr_col = queue_col[head];
        head++;

        if (curr_row == rows - 1 && curr_col == cols - 1) {
            break;
        }

        int max_jump = grid[curr_row][curr_col];

        // Move right
        for (int i = 1; i <= max_jump; i++) {
            if (curr_col + i < cols && dist[curr_row][curr_col + i] == -1) {
                dist[curr_row][curr_col + i] = dist[curr_row][curr_col] + 1;
                queue_row[tail] = curr_row;
                queue_col[tail] = curr_col + i;
                tail++;
            }
        }

        // Move down
        for (int i = 1; i <= max_jump; i++) {
            if (curr_row + i < rows && dist[curr_row + i][curr_col] == -1) {
                dist[curr_row + i][curr_col] = dist[curr_row][curr_col] + 1;
                queue_row[tail] = curr_row + i;
                queue_col[tail] = curr_col;
                tail++;
            }
        }
    }

    int result = dist[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);

    return result;
}