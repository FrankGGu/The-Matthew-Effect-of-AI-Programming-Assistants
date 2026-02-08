#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTotalDistance(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int* x_coords = (int*)malloc(sizeof(int) * rows * cols);
    int* y_coords = (int*)malloc(sizeof(int) * rows * cols);
    int x_count = 0;
    int y_count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                x_coords[x_count++] = i;
                y_coords[y_count++] = j;
            }
        }
    }

    qsort(x_coords, x_count, sizeof(int), cmpfunc);
    qsort(y_coords, y_count, sizeof(int), cmpfunc);

    int median_x = x_coords[x_count / 2];
    int median_y = y_coords[y_count / 2];

    int total_distance = 0;
    for (int i = 0; i < x_count; i++) {
        total_distance += abs(x_coords[i] - median_x) + abs(y_coords[i] - median_y);
    }

    free(x_coords);
    free(y_coords);

    return total_distance;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}