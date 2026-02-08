#include <stdio.h>
#include <stdlib.h>

int* numMovesStonesII(int* stones, int stonesSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));

    if (stonesSize <= 2) {
        result[0] = 0;
        result[1] = 0;
        return result;
    }

    int min = 0, max = 0;
    int i, j;

    for (i = 0; i < stonesSize; i++) {
        for (j = i + 1; j < stonesSize; j++) {
            if (stones[j] - stones[i] == stonesSize - 1) {
                min = 0;
                break;
            }
        }
        if (min == 0) break;
    }

    if (min == 0) {
        result[0] = 0;
    } else {
        for (i = 0; i < stonesSize - 1; i++) {
            if (stones[i + 1] - stones[i] > 1) {
                min += stones[i + 1] - stones[i] - 1;
            }
        }
    }

    max = stones[stonesSize - 1] - stones[0] - stonesSize + 1;

    result[0] = min;
    result[1] = max;

    return result;
}