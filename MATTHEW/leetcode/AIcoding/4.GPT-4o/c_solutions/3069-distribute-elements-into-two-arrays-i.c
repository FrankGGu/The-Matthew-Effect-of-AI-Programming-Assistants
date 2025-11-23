#include <stdlib.h>

int* distributeArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count[2] = {0, 0};

    for (int i = 0; i < numsSize; i++) {
        result[i] = (count[i % 2] < numsSize / 2) ? 0 : 1;
        count[result[i]]++;
    }

    *returnSize = numsSize;
    return result;
}