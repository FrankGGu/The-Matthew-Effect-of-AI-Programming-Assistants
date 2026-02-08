var minCoins = function(coins) {
    let dp = new Array(10001).fill(Infinity);
    dp[0] = 0;

    for (let coin of coins) {
        for (let j = coin; j <= 10000; j++) {
            dp[j] = Math.min(dp[j], dp[j - coin] + 1);
        }
    }

    return dp[10000] === Infinity ? -1 : dp[10000];
};