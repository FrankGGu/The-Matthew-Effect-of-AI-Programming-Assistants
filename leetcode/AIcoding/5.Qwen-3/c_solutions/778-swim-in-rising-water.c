#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int row;
    int col;
} Point;

int compare(const void *a, const void *b) {
    return ((Point *)a)->row - ((Point *)b)->row;
}

int swimInWater(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int visited[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = 0;
        }
    }

    Point pq[n * n];
    int size = 0;

    pq[size].row = 0;
    pq[size++].col = 0;
    visited[0][0] = 1;

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int max_time = grid[0][0];

    while (size > 0) {
        qsort(pq, size, sizeof(Point), compare);
        Point current = pq[0];
        for (int i = 0; i < size - 1; i++) {
            pq[i] = pq[i + 1];
        }
        size--;

        max_time = fmax(max_time, grid[current.row][current.col]);

        if (current.row == n - 1 && current.col == n - 1) {
            return max_time;
        }

        for (int d = 0; d < 4; d++) {
            int newRow = current.row + directions[d][0];
            int newCol = current.col + directions[d][1];
            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                visited[newRow][newCol] = 1;
                pq[size].row = newRow;
                pq[size++].col = newCol;
            }
        }
    }

    return max_time;
}