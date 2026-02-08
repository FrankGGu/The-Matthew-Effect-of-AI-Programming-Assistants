#include <stdlib.h>

int* findXSum(int* nums, int numsSize, int k, int* returnSize) {
    if (nums == NULL || numsSize == 0 || k <= 0 || k > numsSize) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    long long current_sum = 0;
    for (int i = 0; i < k; i++) {
        current_sum += nums[i];
    }
    result[0] = (int)current_sum;

    for (int i = k; i < numsSize; i++) {
        current_sum += nums[i] - nums[i - k];
        result[i - k + 1] = (int)current_sum;
    }

    return result;
}