#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int nums[], int numsSize) {
    int dp[numsSize + 1];
    dp[0] = 0;
    for (int i = 1; i <= numsSize; i++) {
        dp[i] = INT_MAX;
        int sum = 0;
        for (int j = i; j >= 1; j--) {
            sum += nums[j - 1];
            dp[i] = (dp[i] < dp[j - 1] + sum) ? dp[i] : dp[j - 1] + sum;
        }
    }
    return dp[numsSize];
}