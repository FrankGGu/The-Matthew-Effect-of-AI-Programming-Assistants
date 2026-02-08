#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestArithSeqLength(int* nums, int numsSize) {
    if (numsSize <= 2) {
        return numsSize;
    }

    int dp[numsSize][1001];
    int ans = 2;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < 1001; j++) {
            dp[i][j] = 1;
        }
    }

    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            int diff = nums[i] - nums[j] + 500;
            dp[i][diff] = dp[j][diff] + 1;
            if (dp[i][diff] > ans) {
                ans = dp[i][diff];
            }
        }
    }

    return ans;
}