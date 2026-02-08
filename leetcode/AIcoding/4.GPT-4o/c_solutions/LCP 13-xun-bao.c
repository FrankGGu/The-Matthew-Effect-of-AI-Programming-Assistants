#include <stdio.h>
#include <stdlib.h>

int treasureHunt(int** grid, int gridSize, int* gridColSize) {
    int maxTreasure = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > maxTreasure) {
                maxTreasure = grid[i][j];
            }
        }
    }
    return maxTreasure;
}