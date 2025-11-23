int maximumLength(int* nums, int numsSize, int k) {
    int dp[256][256] = {0};
    int maxLen = 1;

    for (int i = 0; i < numsSize; i++) {
        int x = nums[i] % 256;
        for (int r = 0; r <= k; r++) {
            dp[x][r]++;
            if (dp[x][r] > maxLen) {
                maxLen = dp[x][r];
            }
        }

        for (int j = 0; j < 256; j++) {
            if (j == x) continue;
            for (int r = 0; r < k; r++) {
                if (dp[j][r] > 0) {
                    if (dp[j][r] + 1 > dp[x][r+1]) {
                        dp[x][r+1] = dp[j][r] + 1;
                        if (dp[x][r+1] > maxLen) {
                            maxLen = dp[x][r+1];
                        }
                    }
                }
            }
        }
    }

    return maxLen;
}