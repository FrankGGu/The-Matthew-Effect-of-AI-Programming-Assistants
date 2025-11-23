var maxProfit = function(prices) {
    const n = prices.length;
    if (n === 0) return 0;

    let dp = Array(n).fill(0).map(() => Array(2).fill(0));
    dp[0][0] = 0; // not holding stock
    dp[0][1] = -prices[0]; // holding stock

    for (let i = 1; i < n; i++) {
        dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
        dp[i][1] = Math.max(dp[i - 1][1], dp[i - 2] ? dp[i - 2][0] - prices[i] : -prices[i]);
    }

    return dp[n - 1][0];
};