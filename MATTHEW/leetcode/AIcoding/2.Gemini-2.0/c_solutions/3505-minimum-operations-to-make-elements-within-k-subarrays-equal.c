#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int k) {
    int dp[numsSize + 1];
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = INT_MAX;
        for (int j = 1; j <= i; j++) {
            if (i - j + 1 <= k) {
                int count[200001] = {0};
                int maxCount = 0;
                for (int l = i - j; l < i; l++) {
                    count[nums[l] + 100000]++;
                    if (count[nums[l] + 100000] > maxCount) {
                        maxCount = count[nums[l] + 100000];
                    }
                }
                if (dp[i - j] != INT_MAX && dp[i - j] + (i - (i - j + 1) + 1) - maxCount < dp[i]) {
                    dp[i] = dp[i - j] + (i - (i - j + 1) + 1) - maxCount;
                }
            }
        }
    }

    return dp[numsSize];
}