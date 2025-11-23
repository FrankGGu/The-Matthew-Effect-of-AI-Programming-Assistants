var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(null).map(() => Array(m + 1).fill(-Infinity));

    dp[0][0] = 0;

    for (let i = 1; i <= m; i++) {
        for (let left = 0; left <= i; left++) {
            const right = i - left;
            if (left > 0) {
                dp[i][left] = Math.max(dp[i][left], dp[i - 1][left - 1] + nums[left - 1] * multipliers[i - 1]);
            }
            if (right > 0) {
                dp[i][left] = Math.max(dp[i][left], dp[i - 1][left] + nums[n - right] * multipliers[i - 1]);
            }
        }
    }

    let maxScore = -Infinity;
    for (let left = 0; left <= m; left++) {
        maxScore = Math.max(maxScore, dp[m][left]);
    }

    return maxScore;
};