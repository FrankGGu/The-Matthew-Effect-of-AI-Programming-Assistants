#include <stdio.h>
#include <stdlib.h>

int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 0;
    if (k == 0) {
        int* result = (int*)malloc(numsSize * sizeof(int));
        for (int i = 0; i < numsSize; i++) {
            result[i] = nums[i];
        }
        *returnSize = numsSize;
        return result;
    }
    int windowSize = 2 * k + 1;
    if (windowSize > numsSize) {
        return NULL;
    }
    int* result = (int*)malloc((numsSize - windowSize + 1) * sizeof(int));
    *returnSize = numsSize - windowSize + 1;
    long long sum = 0;
    for (int i = 0; i < windowSize; i++) {
        sum += nums[i];
    }
    result[0] = sum / windowSize;
    for (int i = 1; i <= numsSize - windowSize; i++) {
        sum = sum - nums[i - 1] + nums[i + k];
        result[i] = sum / windowSize;
    }
    return result;
}