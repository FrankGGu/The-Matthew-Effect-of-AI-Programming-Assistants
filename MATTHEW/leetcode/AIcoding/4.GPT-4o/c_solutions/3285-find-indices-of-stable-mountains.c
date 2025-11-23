#include <stdio.h>
#include <stdlib.h>

int* findStableMountains(int* heights, int heightsSize, int* returnSize) {
    int* result = (int*)malloc(heightsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 1; i < heightsSize - 1; i++) {
        if (heights[i] > heights[i - 1] && heights[i] > heights[i + 1]) {
            result[(*returnSize)++] = i;
        }
    }

    result = (int*)realloc(result, (*returnSize) * sizeof(int));
    return result;
}