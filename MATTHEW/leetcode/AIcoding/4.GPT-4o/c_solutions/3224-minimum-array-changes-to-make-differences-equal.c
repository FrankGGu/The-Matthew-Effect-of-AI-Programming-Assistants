int minChanges(int* nums, int numsSize, int k) {
    int dp[101][101] = {0};
    int count[101] = {0};
    for (int j = 0; j < k; j++) {
        memset(count, 0, sizeof(count));
        for (int i = j; i < numsSize; i += k) {
            count[nums[i]]++;
        }
        int maxCount = 0;
        for (int i = 0; i < 101; i++) {
            if (count[i] > maxCount) {
                maxCount = count[i];
            }
        }
        for (int i = 0; i <= j; i++) {
            dp[j][i] = dp[j][i - 1] + 1;
        }
        for (int i = j; i < numsSize; i += k) {
            for (int x = 0; x <= j; x++) {
                dp[j][x] = fmin(dp[j][x], dp[j][x - 1] + (i + k - 1) / k);
            }
        }
        for (int i = 0; i <= j; i++) {
            dp[j + 1][i] = fmin(dp[j][i] + (numsSize / k) - maxCount, dp[j + 1][i]);
        }
    }
    return dp[k][0];
}