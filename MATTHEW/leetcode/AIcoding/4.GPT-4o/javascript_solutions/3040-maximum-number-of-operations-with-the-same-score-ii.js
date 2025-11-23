function maximumScore(nums, multipliers) {
    const n = nums.length, m = multipliers.length;
    const dp = Array(m + 1).fill(0).map(() => Array(m + 1).fill(-Infinity));
    dp[0][0] = 0;

    for (let i = 0; i < m; i++) {
        for (let left = 0; left <= i; left++) {
            const right = i - left;
            if (left < n) {
                dp[i + 1][left + 1] = Math.max(dp[i + 1][left + 1], dp[i][left] + nums[left] * multipliers[i]);
            }
            if (right < n) {
                dp[i + 1][left] = Math.max(dp[i + 1][left], dp[i][left] + nums[n - 1 - right] * multipliers[i]);
            }
        }
    }

    let result = -Infinity;
    for (let i = 0; i <= m; i++) {
        result = Math.max(result, dp[m][i]);
    }
    return result;
}