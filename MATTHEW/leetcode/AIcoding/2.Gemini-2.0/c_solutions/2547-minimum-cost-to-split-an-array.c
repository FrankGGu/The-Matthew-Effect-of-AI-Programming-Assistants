#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* nums, int numsSize, int k) {
    int n = numsSize;
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= i; j++) {
            int cost = k;
            int count[101] = {0};
            int redundancy = 0;
            for (int l = i; l >= j; l--) {
                count[nums[l - 1]]++;
                if (count[nums[l - 1]] > 1) {
                    if (count[nums[l - 1]] == 2)
                        redundancy += 2;
                    else
                        redundancy++;
                }
            }
            cost += redundancy;

            if (dp[j - 1] != INT_MAX && dp[j - 1] + cost < dp[i]) {
                dp[i] = dp[j - 1] + cost;
            }
        }
    }

    return dp[n];
}