#include <stdio.h>
#include <stdlib.h>

int* goodIndices(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc((numsSize - 2 * k) * sizeof(int));
    int* left = (int*)malloc(numsSize * sizeof(int));
    int* right = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == 0 || nums[i] <= nums[i - 1]) {
            left[i] = (i == 0) ? 1 : left[i - 1] + 1;
        } else {
            left[i] = 0;
        }
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        if (i == numsSize - 1 || nums[i] <= nums[i + 1]) {
            right[i] = (i == numsSize - 1) ? 1 : right[i + 1] + 1;
        } else {
            right[i] = 0;
        }
    }

    for (int i = k; i < numsSize - k; i++) {
        if (left[i - 1] >= k && right[i + 1] >= k) {
            result[(*returnSize)++] = i;
        }
    }

    free(left);
    free(right);
    return result;
}