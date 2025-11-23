var minimumCost = function(nums) {
    const n = nums.length;
    const freq = new Array(100001).fill(0);
    for (const num of nums) {
        freq[num]++;
    }

    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        for (let j = 1; j <= 100000; j++) {
            if (freq[j] > 0) {
                dp[i] = Math.min(dp[i], dp[i - freq[j]] + 1);
            }
        }
    }

    return dp[n];
};