function maxScore(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1] + nums[i];
    }
    let maxScore = dp[0];
    for (let i = 1; i < n; i++) {
        if (dp[i] > maxScore) {
            maxScore = dp[i];
        }
    }
    return maxScore;
}