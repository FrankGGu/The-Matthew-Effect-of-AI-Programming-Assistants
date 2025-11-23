var maxScore = function(nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + nums[i - 1];
    }

    let maxScore = dp[n];

    for (let i = n - 1; i >= 0; i--) {
        maxScore = Math.max(maxScore, dp[i] + (n - i) * (n - i - 1) / 2);
    }

    return maxScore;
};