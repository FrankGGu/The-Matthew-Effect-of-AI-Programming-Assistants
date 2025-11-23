#include <stdlib.h>

int* findXSumOfAllKLongSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize < k || k <= 0) {
        *returnSize = 0;
        return NULL;
    }

    int numSubarrays = numsSize - k + 1;
    int* result = (int*)malloc(numSubarrays * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    long long currentSum = 0;
    for (int i = 0; i < k; i++) {
        currentSum += nums[i];
    }
    result[0] = (int)currentSum;

    for (int i = k; i < numsSize; i++) {
        currentSum -= nums[i - k];
        currentSum += nums[i];
        result[i - k + 1] = (int)currentSum;
    }

    *returnSize = numSubarrays;
    return result;
}