#include <stdio.h>
#include <stdlib.h>

int* findMissingAndRepeatedValue(int* grid, int gridSize, int* gridColSize, int* returnSize) {
    int n = gridSize;
    int* freq = (int*)calloc(n * n + 1, sizeof(int));
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int num = grid[i][j];
            freq[num]++;
        }
    }

    int repeated = -1, missing = -1;
    for (int i = 1; i <= n * n; i++) {
        if (freq[i] == 2) repeated = i;
        if (freq[i] == 0) missing = i;
    }

    result[0] = missing;
    result[1] = repeated;
    free(freq);
    return result;
}