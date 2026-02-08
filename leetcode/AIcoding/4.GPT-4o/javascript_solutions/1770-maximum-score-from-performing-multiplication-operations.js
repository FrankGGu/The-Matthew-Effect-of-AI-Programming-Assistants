var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(0).map(() => Array(m + 1).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let left = 0; left <= i; left++) {
            const right = n - 1 - (i - left);
            dp[left][i - left] = Math.max(
                nums[left] * multipliers[i] + dp[left + 1][i - left - 1],
                nums[right] * multipliers[i] + dp[left][i - left - 1]
            );
        }
    }

    return dp[0][0];
};