#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int solve(int *nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int dp[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    int maxLen = 1;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if ((double)nums[i] <= (double)nums[j] * k) {
                dp[i] = (dp[i] > dp[j] + 1) ? dp[i] : (dp[j] + 1);
            }
        }
        maxLen = (maxLen > dp[i]) ? maxLen : dp[i];
    }

    return maxLen;
}