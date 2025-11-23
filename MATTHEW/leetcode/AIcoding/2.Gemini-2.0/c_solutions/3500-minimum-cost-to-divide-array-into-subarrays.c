#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* nums, int numsSize, int k) {
    int dp[numsSize + 1];
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = INT_MAX;
        for (int j = 1; j <= i; j++) {
            int cost = k;
            int freq[101] = {0};
            int maxFreq = 0;
            for (int l = i - 1; l >= i - j; l--) {
                freq[nums[l]]++;
                if (freq[nums[l]] > maxFreq) {
                    maxFreq = freq[nums[l]];
                }
            }
            cost += j - maxFreq;
            if (dp[i - j] != INT_MAX && dp[i - j] + cost < dp[i]) {
                dp[i] = dp[i - j] + cost;
            }
        }
    }

    return dp[numsSize];
}