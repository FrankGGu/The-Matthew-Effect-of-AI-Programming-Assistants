#include <stdio.h>
#include <stdlib.h>

int minSwaps(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize, swaps = 0;
    int* rowZeros = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = n - 1; j >= 0; j--) {
            if (grid[i][j] == 0) count++;
            else break;
        }
        rowZeros[i] = count;
    }

    for (int i = 0; i < n; i++) {
        int required = n - 1 - i;
        if (rowZeros[i] < required) {
            int j = i;
            while (j < n && rowZeros[j] < required) j++;
            if (j == n) return -1;
            for (int k = j; k > i; k--) {
                int temp = rowZeros[k];
                rowZeros[k] = rowZeros[k - 1];
                rowZeros[k - 1] = temp;
                swaps++;
            }
        }
    }

    free(rowZeros);
    return swaps;
}