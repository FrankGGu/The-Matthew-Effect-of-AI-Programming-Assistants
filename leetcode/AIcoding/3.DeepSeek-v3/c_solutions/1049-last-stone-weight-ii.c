int lastStoneWeightII(int* stones, int stonesSize) {
    int sum = 0;
    for (int i = 0; i < stonesSize; i++) {
        sum += stones[i];
    }

    int target = sum / 2;
    int dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < stonesSize; i++) {
        for (int j = target; j >= stones[i]; j--) {
            if (dp[j] < dp[j - stones[i]] + stones[i]) {
                dp[j] = dp[j - stones[i]] + stones[i];
            }
        }
    }

    return sum - 2 * dp[target];
}