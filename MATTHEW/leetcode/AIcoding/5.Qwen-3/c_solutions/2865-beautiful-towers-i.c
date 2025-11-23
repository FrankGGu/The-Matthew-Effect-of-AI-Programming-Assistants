#include <stdio.h>
#include <stdlib.h>

int* getSortedTowers(int* heights, int heightsSize, int** returnColumnSizes) {
    int* result = (int*)malloc(heightsSize * sizeof(int));
    int* sortedHeights = (int*)malloc(heightsSize * sizeof(int));
    for (int i = 0; i < heightsSize; i++) {
        sortedHeights[i] = heights[i];
    }

    for (int i = 0; i < heightsSize; i++) {
        int minIndex = i;
        for (int j = i + 1; j < heightsSize; j++) {
            if (sortedHeights[j] < sortedHeights[minIndex]) {
                minIndex = j;
            }
        }
        int temp = sortedHeights[i];
        sortedHeights[i] = sortedHeights[minIndex];
        sortedHeights[minIndex] = temp;
    }

    int* columnSizes = (int*)malloc(heightsSize * sizeof(int));
    for (int i = 0; i < heightsSize; i++) {
        columnSizes[i] = 1;
        result[i] = sortedHeights[i];
    }

    *returnColumnSizes = columnSizes;
    return result;
}