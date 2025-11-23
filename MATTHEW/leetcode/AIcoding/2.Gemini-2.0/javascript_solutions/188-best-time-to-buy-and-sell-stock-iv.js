var maxProfit = function(k, prices) {
    const n = prices.length;
    if (n <= 1) {
        return 0;
    }

    if (k >= n / 2) {
        let profit = 0;
        for (let i = 1; i < n; i++) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1];
            }
        }
        return profit;
    }

    const dp = Array(k + 1).fill(null).map(() => Array(2).fill(0));

    for (let i = 0; i <= k; i++) {
        dp[i][0] = 0;
        dp[i][1] = -Infinity;
    }

    for (let i = 0; i < n; i++) {
        for (let j = k; j > 0; j--) {
            dp[j][1] = Math.max(dp[j][1], dp[j - 1][0] - prices[i]);
            dp[j][0] = Math.max(dp[j][0], dp[j][1] + prices[i]);
        }
    }

    return dp[k][0];
};