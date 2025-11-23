#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSubarraySum(int* nums, int numsSize, int k) {
    int* prefixMod = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        prefixMod[i] = INT_MIN;
    }

    int prefixSum = 0;
    int maxSum = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        int mod = prefixSum % k;
        if (mod < 0) mod += k;

        if (prefixMod[mod] != INT_MIN) {
            maxSum = (maxSum > (prefixSum - prefixMod[mod])) ? maxSum : (prefixSum - prefixMod[mod]);
        } else {
            if (i + 1 >= k) {
                maxSum = (maxSum > prefixSum) ? maxSum : prefixSum;
            }
        }

        if (prefixMod[mod] == INT_MIN) {
            prefixMod[mod] = prefixSum;
        }
    }

    free(prefixMod);
    return maxSum;
}