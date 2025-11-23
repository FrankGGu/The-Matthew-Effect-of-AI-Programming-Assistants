#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAlternatingGroups(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return numsSize;
    }

    int dp[numsSize][2];
    for (int i = 0; i < numsSize; i++) {
        dp[i][0] = dp[i][1] = 1;
    }

    int maxLen = 1;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i][0] = (dp[i][0] > dp[j][1] + 1) ? dp[i][0] : dp[j][1] + 1;
                maxLen = (maxLen > dp[i][0]) ? maxLen : dp[i][0];
            } else if (nums[i] < nums[j]) {
                dp[i][1] = (dp[i][1] > dp[j][0] + 1) ? dp[i][1] : dp[j][0] + 1;
                maxLen = (maxLen > dp[i][1]) ? maxLen : dp[i][1];
            }
        }
    }

    return maxLen;
}