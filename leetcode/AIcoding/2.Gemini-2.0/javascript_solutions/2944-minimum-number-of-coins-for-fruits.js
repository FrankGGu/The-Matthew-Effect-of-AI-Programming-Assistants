var minimumCoins = function(prices) {
    const n = prices.length;
    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = prices[i - 1];
        let minPrev = Infinity;
        for (let j = 1; j <= i; j++) {
            minPrev = Math.min(minPrev, (j - 1 > 0 ? dp[j - 1] : 0) + prices[i - 1]);
        }
        dp[i] = minPrev;
         for (let j = 1; j <= i; j++) {
             if (i - j <= prices[j-1]) {
                 dp[i] = Math.min(dp[i], (j - 1 > 0 ? dp[j - 1] : 0) + prices[i-1]);
             }
         }
        let bestPrev = Infinity;

        for (let j = 1; j <= i; j++) {
            if (i - j <= prices[j - 1]) {
                bestPrev = Math.min(bestPrev, (j - 1 > 0 ? dp[j - 1] : 0));
            }
        }

        if (bestPrev !== Infinity) {
            dp[i] = Math.min(dp[i], bestPrev + prices[i - 1]);
        }
    }

    return dp[n];
};