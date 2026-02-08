var findCheapestPrice = function(n, flights, src, dst, k) {
    let dp = Array(k + 2).fill(null).map(() => Array(n).fill(Infinity));
    for (let i = 0; i <= k + 1; i++) {
        dp[i][src] = 0;
    }

    for (let i = 1; i <= k + 1; i++) {
        for (const [u, v, price] of flights) {
            dp[i][v] = Math.min(dp[i][v], dp[i - 1][u] + price);
        }
    }

    let result = Infinity;
    for (let i = 0; i <= k + 1; i++) {
        result = Math.min(result, dp[i][dst]);
    }

    return result === Infinity ? -1 : result;
};