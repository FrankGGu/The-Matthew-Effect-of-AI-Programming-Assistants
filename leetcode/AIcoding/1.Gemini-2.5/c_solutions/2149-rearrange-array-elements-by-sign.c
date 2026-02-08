#include <stdlib.h>

int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int pos_idx = 0;
    int neg_idx = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            result[pos_idx] = nums[i];
            pos_idx += 2;
        } else {
            result[neg_idx] = nums[i];
            neg_idx += 2;
        }
    }

    return result;
}