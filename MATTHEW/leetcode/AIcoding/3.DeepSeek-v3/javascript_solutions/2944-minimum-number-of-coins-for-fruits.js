var minimumCoins = function(fruits) {
    const n = fruits.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[n] = 0;

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i + 1; j <= Math.min(2 * i + 1, n); j++) {
            dp[i] = Math.min(dp[i], fruits[i] + dp[j]);
        }
    }

    return dp[0];
};