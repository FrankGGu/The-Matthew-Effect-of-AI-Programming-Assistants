var minimumOperations = function(nums) {
    const n = nums.length;
    let dp = new Array(n + 1).fill(0).map(() => new Array(4).fill(Infinity));
    dp[0][1] = 0;
    dp[0][2] = 0;
    dp[0][3] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= 3; j++) {
            for (let k = 1; k <= j; k++) {
                const cost = nums[i - 1] !== j ? 1 : 0;
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + cost);
            }
        }
    }

    return Math.min(dp[n][1], dp[n][2], dp[n][3]);
};