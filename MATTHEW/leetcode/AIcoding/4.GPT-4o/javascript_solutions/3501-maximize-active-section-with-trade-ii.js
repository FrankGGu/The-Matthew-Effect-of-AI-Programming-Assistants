var maxProfit = function(prices) {
    let n = prices.length;
    if (n < 2) return 0;

    let dp = Array.from({ length: n }, () => Array(3).fill(0));

    for (let i = 1; i <= 2; i++) {
        let maxDiff = -prices[0];
        for (let j = 1; j < n; j++) {
            dp[j][i] = Math.max(dp[j - 1][i], prices[j] + maxDiff);
            maxDiff = Math.max(maxDiff, dp[j][i - 1] - prices[j]);
        }
    }

    return dp[n - 1][2];
};