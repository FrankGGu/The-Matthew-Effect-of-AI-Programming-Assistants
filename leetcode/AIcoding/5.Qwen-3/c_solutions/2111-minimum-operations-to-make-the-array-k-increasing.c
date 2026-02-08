#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        int idx = i % k;
        int val = nums[i];
        int left = 0, right = dp[idx];
        while (left < right) {
            int mid = (left + right) / 2;
            if (dp[idx] > 0 && dp[idx] <= mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        if (dp[idx] > 0 && dp[idx] <= val) {
            dp[idx] = val;
        } else {
            dp[idx] = val;
        }
    }

    int res = 0;
    for (int i = 0; i < k; i++) {
        res += dp[i];
    }

    free(dp);
    return res;
}