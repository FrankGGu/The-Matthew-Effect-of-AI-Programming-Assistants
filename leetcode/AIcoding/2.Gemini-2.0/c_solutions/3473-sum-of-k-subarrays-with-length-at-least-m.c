#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSum(int* nums, int numsSize, int k, int m) {
    if (numsSize < k * m) return -1;

    int* dp = (int*)malloc((numsSize + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = dp[i - 1];
        int sum = 0;
        if (i >= m) {
            for (int j = i; j > i - m; j--) {
                sum += nums[j - 1];
            }
            if (i == m) {
                dp[i] = (dp[i] > sum) ? dp[i] : sum;
            } else {
                int prev = dp[i - m];
                dp[i] = (dp[i] > (prev + sum)) ? dp[i] : (prev + sum);
            }
        }
    }

    if (k == 1) {
        int res = 0;
        for (int i = m; i <= numsSize; i++) {
            int sum = 0;
            for (int j = i; j > i - m; j--) {
                sum += nums[j - 1];
            }
            if (res < sum) res = sum;
            for (int j = i + 1; j <= numsSize; j++) {
                sum += nums[j - 1];
                sum -= nums[j - m - 1];
                if (res < sum) res = sum;
            }
        }
        free(dp);
        return res;
    }

    int* dp2 = (int*)malloc((numsSize + 1) * sizeof(int));

    for (int l = 2; l <= k; l++) {
        for (int i = 0; i <= numsSize; i++) dp2[i] = INT_MIN;

        for (int i = l * m; i <= numsSize; i++) {
            dp2[i] = dp2[i - 1];
            int sum = 0;
            for (int j = i; j > i - m; j--) {
                sum += nums[j - 1];
            }
            int prev = dp[i - m];
            dp2[i] = (dp2[i] > (prev + sum)) ? dp2[i] : (prev + sum);
        }

        free(dp);
        dp = dp2;
        dp2 = (int*)malloc((numsSize + 1) * sizeof(int));
    }

    int result = dp[numsSize];
    free(dp);
    free(dp2);
    return result;
}