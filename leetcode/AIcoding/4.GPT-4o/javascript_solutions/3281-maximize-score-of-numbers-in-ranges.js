var maximizeScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(0).map(() => Array(m + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let left = 0; left <= i; left++) {
            const right = i - left;
            if (left > 0) {
                dp[left][right] = Math.max(dp[left][right], dp[left - 1][right] + nums[left - 1] * multipliers[i - 1]);
            }
            if (right > 0) {
                dp[left][right] = Math.max(dp[left][right], dp[left][right - 1] + nums[n - right] * multipliers[i - 1]);
            }
        }
    }
    return Math.max(...dp.map(row => row[m]));
};