#include <stdio.h>
#include <stdlib.h>

int findChampion(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    for (int i = 0; i < n; i++) {
        int champion = 1;
        for (int j = 0; j < n; j++) {
            if (i != j && grid[i][j] == 0) {
                champion = 0;
                break;
            }
        }
        if (champion) return i;
    }
    return -1;
}