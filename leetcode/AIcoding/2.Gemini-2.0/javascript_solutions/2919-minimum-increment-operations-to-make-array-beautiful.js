var minIncrementOperations = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(3, i); j++) {
            let cost = 0;
            if (j === 3) {
                let maxVal = Math.max(nums[i - 1], nums[i - 2], nums[i - 3]);
                cost = Math.max(0, k - maxVal);
            }
            dp[i] = Math.min(dp[i], dp[i - j] + cost);
        }
    }

    return dp[n];
};