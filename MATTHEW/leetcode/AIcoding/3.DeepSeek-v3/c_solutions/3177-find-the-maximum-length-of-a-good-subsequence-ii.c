#define max(a, b) ((a) > (b) ? (a) : (b))

int maximumLength(int* nums, int numsSize, int k) {
    int dp[numsSize][k + 1];
    int maxLen[k + 1];
    int result = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 1;
        }
    }

    for (int j = 0; j <= k; j++) {
        maxLen[j] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            if (j > 0) {
                dp[i][j] = max(dp[i][j], maxLen[j - 1] + 1);
            }
            dp[i][j] = max(dp[i][j], maxLen[j] + 1);
        }

        for (int j = 0; j <= k; j++) {
            if (dp[i][j] > maxLen[j]) {
                maxLen[j] = dp[i][j];
            }
        }

        for (int j = 0; j <= k; j++) {
            result = max(result, dp[i][j]);
        }
    }

    return result;
}