#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findBall(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];
    int* result = (int*)malloc(sizeof(int) * n);
    *returnSize = n;

    for (int j = 0; j < n; j++) {
        int col = j;
        int row = 0;
        while (row < m) {
            int next_col = col + grid[row][col];
            if (next_col < 0 || next_col >= n || grid[row][col] != grid[row][next_col]) {
                result[j] = -1;
                goto next_ball;
            }
            col = next_col;
            row++;
        }
        result[j] = col;
        next_ball:;
    }

    return result;
}