#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int lengthOfLIS(int* nums, int numsSize, int k) {
    int dp[100001] = {0};
    int max_val = 0;

    for (int i = 0; i < numsSize; i++) {
        int val = nums[i];
        int start = max(1, val - k);
        int lis = 0;

        for (int j = start; j < val; j++) {
            lis = max(lis, dp[j]);
        }

        dp[val] = lis + 1;
        max_val = max(max_val, dp[val]);
    }

    return max_val;
}