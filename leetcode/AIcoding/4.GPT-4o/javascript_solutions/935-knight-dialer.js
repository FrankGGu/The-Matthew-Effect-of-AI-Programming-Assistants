var knightDialer = function(n) {
    const mod = 1e9 + 7;
    const moves = [
        [4, 6],
        [6, 8],
        [7, 9],
        [4, 8],
        [0, 3],
        [],
        [0, 1],
        [2, 6],
        [1, 3],
        [2, 4]
    ];

    const dp = Array.from({ length: 10 }, () => Array(n + 1).fill(0));

    for (let i = 0; i < 10; i++) {
        dp[i][1] = 1;
    }

    for (let j = 2; j <= n; j++) {
        for (let i = 0; i < 10; i++) {
            for (const move of moves[i]) {
                dp[i][j] = (dp[i][j] + dp[move][j - 1]) % mod;
            }
        }
    }

    let result = 0;
    for (let i = 0; i < 10; i++) {
        result = (result + dp[i][n]) % mod;
    }

    return result;
};