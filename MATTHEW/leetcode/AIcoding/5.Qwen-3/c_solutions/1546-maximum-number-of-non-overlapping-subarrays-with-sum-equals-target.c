#include <stdio.h>
#include <stdlib.h>

int maxSubarraySum(int* nums, int numsSize, int target) {
    int count = 0;
    int prefixSum = 0;
    int* prefixSums = (int*)malloc((numsSize + 1) * sizeof(int));
    prefixSums[0] = 0;

    for (int i = 0; i < numsSize; ++i) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    for (int i = 0; i < numsSize; ++i) {
        for (int j = i + 1; j <= numsSize; ++j) {
            if (prefixSums[j] - prefixSums[i] == target) {
                count++;
                i = j - 1;
                break;
            }
        }
    }

    free(prefixSums);
    return count;
}