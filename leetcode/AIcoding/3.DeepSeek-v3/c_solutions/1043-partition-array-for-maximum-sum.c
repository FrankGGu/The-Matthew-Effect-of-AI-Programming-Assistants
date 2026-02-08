int maxSumAfterPartitioning(int* arr, int arrSize, int k) {
    int dp[arrSize + 1];
    dp[0] = 0;

    for (int i = 1; i <= arrSize; i++) {
        int maxVal = 0;
        int maxSum = 0;
        for (int j = 1; j <= k && i - j >= 0; j++) {
            if (arr[i - j] > maxVal) {
                maxVal = arr[i - j];
            }
            int current = dp[i - j] + maxVal * j;
            if (current > maxSum) {
                maxSum = current;
            }
        }
        dp[i] = maxSum;
    }

    return dp[arrSize];
}