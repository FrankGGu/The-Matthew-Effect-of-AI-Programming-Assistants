int specialPerm(int* nums, int numsSize) {
    int n = numsSize;
    int mod = 1e9 + 7;
    int total = 1 << n;
    long long dp[total][n];

    for (int i = 0; i < total; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        dp[1 << i][i] = 1;
    }

    for (int mask = 0; mask < total; mask++) {
        for (int last = 0; last < n; last++) {
            if (!(mask & (1 << last))) continue;
            for (int next = 0; next < n; next++) {
                if (mask & (1 << next)) continue;
                if (nums[last] % nums[next] == 0 || nums[next] % nums[last] == 0) {
                    dp[mask | (1 << next)][next] = (dp[mask | (1 << next)][next] + dp[mask][last]) % mod;
                }
            }
        }
    }

    long long res = 0;
    for (int i = 0; i < n; i++) {
        res = (res + dp[total - 1][i]) % mod;
    }
    return res;
}