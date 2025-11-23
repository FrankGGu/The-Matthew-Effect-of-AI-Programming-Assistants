var minCost = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        const freq = new Map();
        let trimmed = 0;
        for (let j = i - 1; j >= 0; j--) {
            const num = nums[j];
            freq.set(num, (freq.get(num) || 0) + 1);
            if (freq.get(num) === 2) {
                trimmed += 2;
            } else if (freq.get(num) > 2) {
                trimmed += 1;
            }
            dp[i] = Math.min(dp[i], dp[j] + k + trimmed);
        }
    }

    return dp[n];
};