#include <stdio.h>
#include <stdlib.h>

int* leftmostBuildingQueries(int* a, int aSize, int* b, int bSize, int* returnSize) {
    int* result = (int*)malloc(aSize * sizeof(int));
    *returnSize = aSize;

    for (int i = 0; i < aSize; i++) {
        int maxVal = -1;
        for (int j = 0; j < bSize; j++) {
            if (a[i] < b[j]) {
                maxVal = j;
                break;
            }
        }
        if (maxVal == -1) {
            result[i] = -1;
        } else {
            result[i] = maxVal;
        }
    }

    return result;
}