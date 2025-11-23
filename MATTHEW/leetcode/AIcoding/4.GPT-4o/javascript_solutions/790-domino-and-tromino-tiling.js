var numTilings = function(N) {
    const MOD = 1e9 + 7;
    if (N === 0) return 1;
    if (N === 1) return 1;

    let dp = new Array(N + 1).fill(0);
    let dp2 = new Array(N + 1).fill(0);
    dp[0] = 1;
    dp[1] = 1;
    dp[2] = 2;

    for (let i = 3; i <= N; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2] * 2) % MOD;
    }

    return dp[N];
};