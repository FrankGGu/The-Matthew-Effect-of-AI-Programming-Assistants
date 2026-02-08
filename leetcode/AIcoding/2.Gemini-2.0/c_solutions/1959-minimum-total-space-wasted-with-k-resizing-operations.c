#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSpaceWastedKResizing(int* nums, int numsSize, int k) {
    int n = numsSize;
    int dp[n + 1][k + 2];
    int prefix_sum[n + 1];

    prefix_sum[0] = 0;
    for (int i = 1; i <= n; i++) {
        prefix_sum[i] = prefix_sum[i - 1] + nums[i - 1];
    }

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k + 1; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k + 1; j++) {
            for (int x = 1; x <= i; x++) {
                int max_val = 0;
                for (int l = x - 1; l < i; l++) {
                    if (nums[l] > max_val) {
                        max_val = nums[l];
                    }
                }

                if (j > 0 && dp[x - 1][j - 1] != INT_MAX) {
                    int wasted = max_val * (i - x + 1) - (prefix_sum[i] - prefix_sum[x - 1]);
                    if (wasted < 0) wasted = INT_MAX;
                    if (dp[x - 1][j - 1] != INT_MAX && wasted != INT_MAX) {
                        if ((long long)dp[x - 1][j - 1] + wasted < INT_MAX)
                            dp[i][j] = (dp[i][j] < dp[x - 1][j - 1] + wasted) ? dp[i][j] : dp[x - 1][j - 1] + wasted;
                        else
                            dp[i][j] = dp[i][j];
                    }
                }
            }
            if (dp[i][0] != INT_MAX && j == 0){
                int max_val = 0;
                for(int l = 0; l < i; l++){
                    if(nums[l] > max_val){
                        max_val = nums[l];
                    }
                }
                int wasted = max_val * i - prefix_sum[i];
                dp[i][0] = wasted;
            }

        }
    }

    int ans = INT_MAX;
    for (int j = 0; j <= k + 1; j++) {
        ans = (ans < dp[n][j]) ? ans : dp[n][j];
    }

    return ans;
}