int maxCoins(int* nums, int numsSize) {
    int* balloons = (int*)malloc((numsSize + 2) * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        balloons[i + 1] = nums[i];
    }
    balloons[0] = balloons[numsSize + 1] = 1;

    int** dp = (int**)malloc((numsSize + 2) * sizeof(int*));
    for (int i = 0; i < numsSize + 2; i++) {
        dp[i] = (int*)malloc((numsSize + 2) * sizeof(int));
    }

    for (int length = 1; length <= numsSize; length++) {
        for (int left = 1; left <= numsSize - length + 1; left++) {
            int right = left + length - 1;
            for (int i = left; i <= right; i++) {
                dp[left][right] = fmax(dp[left][right], dp[left][i - 1] + dp[i + 1][right] + balloons[left - 1] * balloons[i] * balloons[right + 1]);
            }
        }
    }

    int result = dp[1][numsSize];
    for (int i = 0; i < numsSize + 2; i++) {
        free(dp[i]);
    }
    free(dp);
    free(balloons);
    return result;
}