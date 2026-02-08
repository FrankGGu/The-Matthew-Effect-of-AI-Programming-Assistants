int countOfPairs(int* nums, int numsSize) {
    int n = numsSize;
    long long mod = 1000000007;

    long long dp[n][101];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= 100; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 0; j <= 100; j++) {
        if (j >= nums[0]) {
            dp[0][j] = 1;
        }
    }

    for (int i = 1; i < n; i++) {
        long long prefix[102];
        prefix[0] = 0;
        for (int j = 0; j <= 100; j++) {
            prefix[j+1] = (prefix[j] + dp[i-1][j]) % mod;
        }

        for (int j = nums[i]; j <= 100; j++) {
            int max_prev = (j <= nums[i-1]) ? j : nums[i-1];
            dp[i][j] = prefix[max_prev+1];
        }
    }

    long long result = 0;
    for (int j = nums[n-1]; j <= 100; j++) {
        result = (result + dp[n-1][j]) % mod;
    }

    return (int)result;
}