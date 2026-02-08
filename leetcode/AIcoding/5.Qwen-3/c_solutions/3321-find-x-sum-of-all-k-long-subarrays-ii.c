#include <stdio.h>
#include <stdlib.h>

int* kLongestSubarraySum(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 0;
    if (k > numsSize || k <= 0) return NULL;

    int* result = (int*)malloc(numsSize - k + 1 * sizeof(int));
    if (!result) return NULL;

    for (int i = 0; i <= numsSize - k; i++) {
        int sum = 0;
        for (int j = 0; j < k; j++) {
            sum += nums[i + j];
        }
        result[*returnSize] = sum;
        (*returnSize)++;
    }

    return result;
}