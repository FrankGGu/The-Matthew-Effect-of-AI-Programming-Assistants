/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int minSumOfValues(int* nums, int numsSize, int* andValues, int andValuesSize) {
    int n = numsSize, m = andValuesSize;
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            dp[i][j] = INT_MAX / 2;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= m; j++) {
            if (dp[i][j] == INT_MAX / 2) continue;

            int curr_and = -1;
            for (int k = i; k < n; k++) {
                if (curr_and == -1) curr_and = nums[k];
                else curr_and &= nums[k];

                if (j < m && curr_and == andValues[j]) {
                    if (dp[k + 1][j + 1] > dp[i][j] + nums[k]) {
                        dp[k + 1][j + 1] = dp[i][j] + nums[k];
                    }
                }

                if (j < m && curr_and < andValues[j]) {
                    break;
                }
            }
        }
    }

    int result = dp[n][m];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result < INT_MAX / 2 ? result : -1;
}