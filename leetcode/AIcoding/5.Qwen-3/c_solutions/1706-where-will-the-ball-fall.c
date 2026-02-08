#include <stdio.h>
#include <stdlib.h>

int* findBall(int** grid, int gridSize, int* gridColSize, int returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int* result = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        int pos = i;
        for (int j = 0; j < rows; j++) {
            int nextPos = pos + grid[j][pos];
            if (nextPos < 0 || nextPos >= cols) {
                pos = -1;
                break;
            }
            pos = nextPos;
        }
        result[i] = pos;
    }

    return result;
}