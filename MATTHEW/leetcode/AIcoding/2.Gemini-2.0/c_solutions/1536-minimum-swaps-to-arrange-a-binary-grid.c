#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwaps(int** grid, int gridSize, int* gridColSize){
    int n = gridSize;
    int* trailingZeros = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        trailingZeros[i] = 0;
        int j = n - 1;
        while (j >= 0 && grid[i][j] == 0) {
            trailingZeros[i]++;
            j--;
        }
    }

    int swaps = 0;
    for (int i = 0; i < n; i++) {
        int required = n - 1 - i;
        if (trailingZeros[i] >= required) {
            continue;
        }
        int j = i + 1;
        while (j < n && trailingZeros[j] < required) {
            j++;
        }
        if (j == n) {
            free(trailingZeros);
            return -1;
        }
        for (int k = j; k > i; k--) {
            int temp = trailingZeros[k];
            trailingZeros[k] = trailingZeros[k - 1];
            trailingZeros[k - 1] = temp;
            swaps++;
        }
    }

    free(trailingZeros);
    return swaps;
}