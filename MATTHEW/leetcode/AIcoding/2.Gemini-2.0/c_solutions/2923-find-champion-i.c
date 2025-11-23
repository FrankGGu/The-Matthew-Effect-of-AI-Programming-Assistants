#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findChampion(int** grid, int gridSize, int* gridColSize) {
    for (int i = 0; i < gridSize; i++) {
        int isChampion = 1;
        for (int j = 0; j < gridSize; j++) {
            if (i != j && grid[j][i] == 1) {
                isChampion = 0;
                break;
            }
        }
        if (isChampion) {
            return i;
        }
    }
    return -1;
}