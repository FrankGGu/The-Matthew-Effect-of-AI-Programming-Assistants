var maxProfit = function(length, prices) {
    const dp = new Array(length + 1).fill(0);
    for (let i = 1; i <= length; i++) {
        for (let j = 1; j <= i; j++) {
            dp[i] = Math.max(dp[i], prices[j - 1] + dp[i - j]);
        }
    }
    return dp[length];
};