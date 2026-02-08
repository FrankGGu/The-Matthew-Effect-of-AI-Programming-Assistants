#include <stdio.h>
#include <stdlib.h>

int equalPairs(int** grid, int gridSize, int* gridColSize) {
    int count = 0;
    int n = gridSize;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int equal = 1;
            for (int k = 0; k < n; k++) {
                if (grid[i][k] != grid[k][j]) {
                    equal = 0;
                    break;
                }
            }
            count += equal;
        }
    }

    return count;
}