#include <stdlib.h> // For malloc

int* sumOfAbsoluteDifferences(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    if (numsSize == 0) {
        return NULL;
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    long long* prefixSum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (prefixSum == NULL) {
        free(result);
        return NULL;
    }

    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        long long current_num = nums[i];

        long long left_sum_abs_diff = (long long)i * current_num - prefixSum[i];

        long long right_sum_abs_diff = (prefixSum[numsSize] - prefixSum[i + 1]) - (long long)(numsSize - 1 - i) * current_num;

        result[i] = (int)(left_sum_abs_diff + right_sum_abs_diff);
    }

    free(prefixSum);

    return result;
}