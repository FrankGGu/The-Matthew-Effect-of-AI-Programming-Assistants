#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isXMatrix(int** grid, int gridSize, int* gridColSize){
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (i == j || i + j == gridSize - 1) {
                if (grid[i][j] == 0) {
                    return false;
                }
            } else {
                if (grid[i][j] != 0) {
                    return false;
                }
            }
        }
    }
    return true;
}