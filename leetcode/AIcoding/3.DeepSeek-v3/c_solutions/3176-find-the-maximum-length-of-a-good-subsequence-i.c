int maximumLength(int* nums, int numsSize, int k) {
    int dp[numsSize][k + 1];
    int maxLen[k + 1];
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 1;
        }
    }

    for (int i = 0; i <= k; i++) {
        maxLen[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            if (j > 0) {
                dp[i][j] = maxLen[j - 1] + 1;
            }
            if (maxLen[j] < dp[i][j]) {
                maxLen[j] = dp[i][j];
            }
        }

        for (int j = 0; j <= k; j++) {
            if (result < dp[i][j]) {
                result = dp[i][j];
            }
        }
    }

    return result;
}