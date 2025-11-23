var maxProfit = function(k, prices) {
    if (prices.length === 0 || k === 0) return 0;
    if (k >= prices.length / 2) {
        let profit = 0;
        for (let i = 1; i < prices.length; i++) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1];
            }
        }
        return profit;
    }

    const dp = Array(k + 1).fill(0).map(() => Array(prices.length).fill(0));

    for (let i = 1; i <= k; i++) {
        let maxDiff = -prices[0];
        for (let j = 1; j < prices.length; j++) {
            dp[i][j] = Math.max(dp[i][j - 1], prices[j] + maxDiff);
            maxDiff = Math.max(maxDiff, dp[i - 1][j] - prices[j]);
        }
    }

    return dp[k][prices.length - 1];
};