#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int equalPairs(int** grid, int gridSize, int* gridColSize){
    int count = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
            int equal = 1;
            for (int k = 0; k < gridSize; k++) {
                if (grid[i][k] != grid[k][j]) {
                    equal = 0;
                    break;
                }
            }
            if (equal) {
                count++;
            }
        }
    }
    return count;
}