#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minSwaps(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int* rowHeights = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        int count = 0;
        for (int j = cols - 1; j >= 0; j--) {
            if (grid[i][j] == '1') {
                count++;
            } else {
                break;
            }
        }
        rowHeights[i] = count;
    }

    qsort(rowHeights, rows, sizeof(int), compare);

    int swaps = 0;
    for (int i = 0; i < rows; i++) {
        int required = i + 1;
        if (rowHeights[i] < required) {
            int j = i + 1;
            while (j < rows && rowHeights[j] < required) {
                j++;
            }
            if (j == rows) {
                free(rowHeights);
                return -1;
            }
            for (int k = j; k > i; k--) {
                int temp = rowHeights[k];
                rowHeights[k] = rowHeights[k - 1];
                rowHeights[k - 1] = temp;
                swaps++;
            }
        }
    }

    free(rowHeights);
    return swaps;
}