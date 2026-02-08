#include <stdio.h>
#include <stdlib.h>

int** reservoirSampling(int** nums, int numsSize, int* numsColSize, int k) {
    int** result = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        result[i] = (int*)malloc(numsColSize[i] * sizeof(int));
    }

    for (int i = 0; i < k; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            result[i][j] = nums[i][j];
        }
    }

    for (int i = k; i < numsSize; i++) {
        int r = rand() % (i + 1);
        if (r < k) {
            for (int j = 0; j < numsColSize[i]; j++) {
                result[r][j] = nums[i][j];
            }
        }
    }

    return result;
}