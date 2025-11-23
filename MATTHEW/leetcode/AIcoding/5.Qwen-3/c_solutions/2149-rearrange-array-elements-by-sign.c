#include <stdio.h>
#include <stdlib.h>

int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    int* positive = (int*)malloc((numsSize / 2) * sizeof(int));
    int* negative = (int*)malloc((numsSize / 2) * sizeof(int));
    int p = 0, n = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            positive[p++] = nums[i];
        } else {
            negative[n++] = nums[i];
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    p = 0;
    n = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            result[i] = positive[p++];
        } else {
            result[i] = negative[n++];
        }
    }

    *returnSize = numsSize;
    free(positive);
    free(negative);
    return result;
}