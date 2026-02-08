var peopleAwareOfSecret = function(n, delay, forget) {
    const mod = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    let total = 0;

    for (let i = 2; i <= n; i++) {
        if (i - delay > 0) {
            dp[i] = (dp[i] + dp[i - delay]) % mod;
        }
        if (i - forget > 0) {
            dp[i] = (dp[i] - dp[i - forget] + mod) % mod;
        }
        total = (total + dp[i]) % mod;
    }

    return total;
};