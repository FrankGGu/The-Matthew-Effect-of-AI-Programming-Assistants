var maxScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = new Array(m + 1).fill(0).map(() => new Array(m + 1).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let left = i; left >= 0; left--) {
            const right = n - 1 - (i - left);
            const mult = multipliers[i];
            dp[i][left] = Math.max(
                mult * nums[left] + dp[i + 1][left + 1],
                mult * nums[right] + dp[i + 1][left]
            );
        }
    }

    return dp[0][0];
};