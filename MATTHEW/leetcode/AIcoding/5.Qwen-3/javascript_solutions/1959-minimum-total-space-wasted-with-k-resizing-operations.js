function minTotalSpaceWasted(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill().map(() => new Array(k + 2).fill(0));
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (let i = 1; i <= n; i++) {
        dp[i][0] = prefix[i] - nums[i - 1] * i;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = Infinity;
            for (let m = i - 1; m >= 0; m--) {
                const current = prefix[i] - prefix[m] - nums[m] * (i - m);
                if (dp[m][j - 1] + current < dp[i][j]) {
                    dp[i][j] = dp[m][j - 1] + current;
                }
            }
        }
    }

    return dp[n][k];
}