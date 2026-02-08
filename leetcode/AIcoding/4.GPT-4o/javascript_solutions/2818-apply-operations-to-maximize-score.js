var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(0).map(() => Array(m + 1).fill(-Infinity));
    dp[0][0] = 0;

    for (let i = 0; i < m; i++) {
        for (let left = 0; left <= i; left++) {
            let right = i - left;
            if (left < n) {
                dp[i + 1][left + 1] = Math.max(dp[i + 1][left + 1], dp[i][left] + nums[left] * multipliers[i]);
            }
            if (right < n) {
                dp[i + 1][left] = Math.max(dp[i + 1][left], dp[i][left] + nums[n - 1 - right] * multipliers[i]);
            }
        }
    }

    let maxScore = -Infinity;
    for (let left = 0; left <= m; left++) {
        maxScore = Math.max(maxScore, dp[m][left]);
    }

    return maxScore;
};