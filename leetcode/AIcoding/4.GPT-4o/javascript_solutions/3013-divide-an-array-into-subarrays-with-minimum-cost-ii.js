function minCost(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(0);
    const count = new Array(101).fill(0);

    for (let i = 1; i <= n; i++) {
        let maxFreq = 0;
        let uniqueCount = 0;
        count.fill(0);

        for (let j = i; j > 0; j--) {
            if (count[nums[j - 1]] === 0) uniqueCount++;
            count[nums[j - 1]]++;
            maxFreq = Math.max(maxFreq, count[nums[j - 1]]);
            dp[i] = Math.min(dp[i] || Infinity, dp[j - 1] + uniqueCount - maxFreq);
        }
    }

    return dp[n];
}