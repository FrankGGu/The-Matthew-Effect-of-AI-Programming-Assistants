var maximumLength = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));
    let maxLen = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = 1;
            for (let prev = 0; prev < i; prev++) {
                if (nums[prev] === nums[i]) {
                    dp[i][j] = Math.max(dp[i][j], dp[prev][j] + 1);
                } else if (j > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[prev][j - 1] + 1);
                }
            }
            maxLen = Math.max(maxLen, dp[i][j]);
        }
    }

    return maxLen;
};