var minimizeXor = function(nums, k) {
    let n = nums.length;
    let limit = 1 << 10;
    let dp = new Array(n + 1).fill(null).map(() => new Array(limit).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let mask = 0; mask < limit; mask++) {
            dp[i][mask] = dp[i - 1][mask | nums[i - 1]];
            if (i >= k) {
                for (let j = 0; j < limit; j++) {
                    dp[i][mask] = Math.min(dp[i][mask], dp[i - k][j] + mask);
                }
            }
        }
    }

    let ans = Infinity;
    for (let mask = 0; mask < limit; mask++) {
        ans = Math.min(ans, dp[n][mask]);
    }

    return ans;
};