var minCost = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);
    const freq = new Map();

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        freq.clear();
        for (let j = i; j > 0 && i - j + 1 <= k; j--) {
            freq.set(nums[j - 1], (freq.get(nums[j - 1]) || 0) + 1);
            dp[i] = Math.min(dp[i], dp[j - 1] + freq.size);
        }
    }

    return dp[n];
};