#include <stdio.h>
#include <stdlib.h>

int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        result[i] = -1;
    }

    if (k == 0) {
        for (int i = 0; i < n; i++) {
            result[i] = nums[i];
        }
        return result;
    }

    int windowSize = 2 * k + 1;
    if (windowSize > n) {
        return result;
    }

    long long sum = 0;
    for (int i = 0; i < windowSize; i++) {
        sum += nums[i];
    }

    result[k] = sum / windowSize;

    for (int i = k + 1; i < n - k; i++) {
        sum = sum - nums[i - k - 1] + nums[i + k];
        result[i] = sum / windowSize;
    }

    return result;
}