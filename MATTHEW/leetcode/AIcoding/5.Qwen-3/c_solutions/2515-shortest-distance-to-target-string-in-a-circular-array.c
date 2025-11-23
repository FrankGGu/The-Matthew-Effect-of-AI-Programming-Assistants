#include <stdio.h>
#include <stdlib.h>

int closetTarget(char** grid, int gridSize, int* gridColSize, char* target, int targetSize) {
    int minDist = gridSize;
    int rows = gridSize;
    int cols = *gridColSize;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == target[0]) {
                int dist = (i * cols + j) % (rows * cols);
                int revDist = (rows * cols - dist) % (rows * cols);
                minDist = (dist < minDist) ? dist : minDist;
                minDist = (revDist < minDist) ? revDist : minDist;
            }
        }
    }

    return minDist;
}