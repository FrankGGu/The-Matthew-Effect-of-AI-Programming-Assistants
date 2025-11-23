var maxProfit = function(prices, discounts) {
    const n = prices.length;
    const dp = new Array(n + 1).fill().map(() => new Array(discounts.length + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= discounts.length; j++) {
            if (j === 0) {
                dp[i][j] = dp[i - 1][j] + prices[i - 1];
            } else {
                const noDiscount = dp[i - 1][j] + prices[i - 1];
                const withDiscount = dp[i - 1][j - 1] + Math.floor(prices[i - 1] * (100 - discounts[j - 1]) / 100);
                dp[i][j] = Math.min(noDiscount, withDiscount);
            }
        }
    }

    const totalCost = dp[n][discounts.length];
    const totalOriginal = prices.reduce((a, b) => a + b, 0);
    return totalOriginal - totalCost;
};