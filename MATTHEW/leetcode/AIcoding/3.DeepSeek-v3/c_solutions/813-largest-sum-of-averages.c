double largestSumOfAverages(int* nums, int numsSize, int k) {
    double prefix[numsSize + 1];
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    double dp[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (prefix[numsSize] - prefix[i]) / (numsSize - i);
    }

    for (int groups = 1; groups < k; groups++) {
        for (int i = 0; i < numsSize; i++) {
            for (int j = i + 1; j < numsSize; j++) {
                double current = (prefix[j] - prefix[i]) / (j - i) + dp[j];
                if (current > dp[i]) {
                    dp[i] = current;
                }
            }
        }
    }

    return dp[0];
}