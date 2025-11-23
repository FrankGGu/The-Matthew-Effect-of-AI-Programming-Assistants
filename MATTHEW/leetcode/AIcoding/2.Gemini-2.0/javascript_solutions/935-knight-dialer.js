var knightDialer = function(n) {
    const MOD = 10**9 + 7;
    const moves = [
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

    let dp = Array(10).fill(1);

    for (let i = 1; i < n; i++) {
        let nextDp = Array(10).fill(0);
        for (let j = 0; j < 10; j++) {
            for (let move of moves[j]) {
                nextDp[move] = (nextDp[move] + dp[j]) % MOD;
            }
        }
        dp = nextDp;
    }

    let total = 0;
    for (let count of dp) {
        total = (total + count) % MOD;
    }

    return total;
};