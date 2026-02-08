var knightDialer = function(n) {
    const MOD = 10 ** 9 + 7;

    const adj = [
        [4, 6],
        [6, 8],
        [7, 9],
        [4, 8],
        [0, 3, 9],
        [],
        [0, 1, 7],
        [2, 6],
        [1, 3],
        [2, 4]
    ];

    let dp = new Array(10).fill(1);

    for (let len = 2; len <= n; len++) {
        let next_dp = new Array(10).fill(0);
        for (let i = 0; i <= 9; i++) {
            for (let nextDigit of adj[i]) {
                next_dp[nextDigit] = (next_dp[nextDigit] + dp[i]) % MOD;
            }
        }
        dp = next_dp;
    }

    let totalCount = 0;
    for (let count of dp) {
        totalCount = (totalCount + count) % MOD;
    }

    return totalCount;
};