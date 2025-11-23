var countWays = function(rooms) {
    const MOD = 1000000007;
    let n = rooms.length;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        if (rooms[i - 1] === 0) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = (dp[i - 1] + dp[i - 2]) % MOD;
        }
    }

    return dp[n];
};