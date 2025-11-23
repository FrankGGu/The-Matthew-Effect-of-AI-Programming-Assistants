#include <stdlib.h>

int* findThePowerOfKSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize < k || k <= 0) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int current_sum = 0;

    for (int i = 0; i < k; ++i) {
        current_sum += nums[i];
    }
    result[0] = current_sum;

    for (int i = 1; i <= numsSize - k; ++i) {
        current_sum -= nums[i - 1];
        current_sum += nums[i + k - 1];
        result[i] = current_sum;
    }

    return result;
}