var maximumTotalCost = function(nums) {
    const n = nums.length;
    if (n === 0) return 0;

    let dp = new Array(n).fill(0).map(() => new Array(2).fill(0));
    dp[0][0] = nums[0];
    dp[0][1] = nums[0];

    for (let i = 1; i < n; i++) {
        dp[i][0] = Math.max(dp[i-1][0] + nums[i], dp[i-1][1] - nums[i]);
        dp[i][1] = Math.max(dp[i-1][0] - nums[i], dp[i-1][1] + nums[i]);
    }

    return Math.max(dp[n-1][0], dp[n-1][1]);
};