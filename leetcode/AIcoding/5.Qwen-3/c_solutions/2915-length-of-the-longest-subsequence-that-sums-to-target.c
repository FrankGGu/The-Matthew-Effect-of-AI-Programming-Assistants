#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int lengthOfLongestSubsequence(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), compare);

    int* dp = (int*)malloc((target + 1) * sizeof(int));
    for (int i = 0; i <= target; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            if (dp[j - nums[i]] != -1) {
                dp[j] = fmax(dp[j], dp[j - nums[i]] + 1);
            }
        }
    }

    int result = dp[target];
    free(dp);
    return result;
}