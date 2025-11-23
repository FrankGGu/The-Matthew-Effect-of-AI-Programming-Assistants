int maxCoins(int* nums, int numsSize) {
    int n = numsSize;
    int* balloons = malloc((n + 2) * sizeof(int));
    balloons[0] = 1;
    balloons[n + 1] = 1;
    for (int i = 0; i < n; i++) {
        balloons[i + 1] = nums[i];
    }

    int newSize = n + 2;
    int** dp = malloc(newSize * sizeof(int*));
    for (int i = 0; i < newSize; i++) {
        dp[i] = calloc(newSize, sizeof(int));
    }

    for (int len = 2; len < newSize; len++) {
        for (int left = 0; left < newSize - len; left++) {
            int right = left + len;
            for (int i = left + 1; i < right; i++) {
                int coins = dp[left][i] + dp[i][right] + balloons[left] * balloons[i] * balloons[right];
                if (coins > dp[left][right]) {
                    dp[left][right] = coins;
                }
            }
        }
    }

    int result = dp[0][newSize - 1];

    for (int i = 0; i < newSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(balloons);

    return result;
}