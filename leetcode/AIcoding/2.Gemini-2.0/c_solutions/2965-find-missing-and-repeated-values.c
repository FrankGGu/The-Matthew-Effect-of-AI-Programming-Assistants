#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findMissingAndRepeatedValues(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int n = gridSize;
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int* count = (int*)calloc(n * n + 1, sizeof(int));
    int repeated = -1;
    int missing = -1;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            count[grid[i][j]]++;
        }
    }

    for (int i = 1; i <= n * n; i++) {
        if (count[i] == 0) {
            missing = i;
        } else if (count[i] > 1) {
            repeated = i;
        }
    }

    result[0] = repeated;
    result[1] = missing;

    free(count);
    return result;
}