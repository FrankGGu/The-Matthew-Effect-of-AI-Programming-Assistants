int sumOfKSubarrays(int* nums, int numsSize, int k, int m) {
    long long *prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    long long *dp = (long long*)malloc((numsSize + 1) * sizeof(long long));
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = 0;
    }

    for (int i = m; i <= numsSize; i++) {
        dp[i] = prefix[i] - prefix[i - m];
    }

    for (int j = 2; j <= k; j++) {
        long long *new_dp = (long long*)malloc((numsSize + 1) * sizeof(long long));
        for (int i = 0; i <= numsSize; i++) {
            new_dp[i] = -1e18;
        }

        long long max_prev = -1e18;
        for (int i = j * m; i <= numsSize; i++) {
            max_prev = (max_prev > dp[i - m]) ? max_prev : dp[i - m];
            if (max_prev != -1e18) {
                new_dp[i] = max_prev + prefix[i] - prefix[i - m];
            }
        }

        free(dp);
        dp = new_dp;
    }

    long long result = -1e18;
    for (int i = k * m; i <= numsSize; i++) {
        if (dp[i] > result) {
            result = dp[i];
        }
    }

    free(prefix);
    free(dp);

    return (result == -1e18) ? 0 : result;
}