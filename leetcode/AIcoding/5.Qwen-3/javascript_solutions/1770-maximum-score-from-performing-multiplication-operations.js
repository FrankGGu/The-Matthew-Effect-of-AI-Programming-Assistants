function maximumScore(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array.from({ length: m + 1 }, () => Array(m + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 0; j <= i; j++) {
            const k = i - j;
            if (j === 0) {
                dp[i][j] = dp[i - 1][j] + nums[n - k] * multipliers[i - 1];
            } else if (k === 0) {
                dp[i][j] = dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1];
            } else {
                dp[i][j] = Math.max(
                    dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1],
                    dp[i - 1][j] + nums[n - k] * multipliers[i - 1]
                );
            }
        }
    }

    let maxScore = 0;
    for (let j = 0; j <= m; j++) {
        maxScore = Math.max(maxScore, dp[m][j]);
    }
    return maxScore;
}