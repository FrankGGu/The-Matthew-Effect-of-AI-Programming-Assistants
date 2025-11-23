var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(0).map(() => Array(m + 1).fill(-Infinity));
    dp[0][0] = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j <= i; j++) {
            if (j < i) {
                dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][j] + nums[j] * multipliers[i]);
            }
            dp[i + 1][j + 1] = Math.max(dp[i + 1][j + 1], dp[i][j] + nums[n - 1 - (i - j)] * multipliers[i]);
        }
    }

    let maxScore = 0;
    for (let j = 0; j <= m; j++) {
        maxScore = Math.max(maxScore, dp[m][j]);
    }

    return maxScore;
};