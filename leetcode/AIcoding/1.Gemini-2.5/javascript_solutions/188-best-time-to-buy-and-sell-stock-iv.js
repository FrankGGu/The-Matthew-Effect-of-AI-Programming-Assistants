var maxProfit = function(k, prices) {
    const n = prices.length;

    if (n === 0 || k === 0) {
        return 0;
    }

    if (k >= n / 2) {
        let maxProfitUnlimited = 0;
        for (let i = 1; i < n; i++) {
            if (prices[i] > prices[i - 1]) {
                maxProfitUnlimited += prices[i] - prices[i - 1];
            }
        }
        return maxProfitUnlimited;
    }

    const dp = Array(k + 1).fill(0).map(() => Array(n).fill(0));

    for (let t = 1; t <= k; t++) {
        let max_diff = -prices[0]; 

        for (let i = 1; i < n; i++) {
            dp[t][i] = Math.max(dp[t][i - 1], prices[i] + max_diff);
            max_diff = Math.max(max_diff, dp[t - 1][i] - prices[i]);
        }
    }

    return dp[k][n - 1];
};