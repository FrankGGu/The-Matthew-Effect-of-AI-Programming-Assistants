var minCost = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        const seen = new Set();
        let uniqueCount = 0;

        for (let j = i; j > 0; j--) {
            if (!seen.has(nums[j - 1])) {
                seen.add(nums[j - 1]);
                uniqueCount++;
            }
            dp[i] = Math.min(dp[i], dp[j - 1] + uniqueCount + k - 1);
        }
    }

    return dp[n];
};