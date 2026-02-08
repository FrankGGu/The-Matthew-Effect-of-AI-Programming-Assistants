var superEggDrop = function(K, N) {
    const dp = Array.from({ length: K + 1 }, () => Array(N + 1).fill(0));

    for (let i = 1; i <= K; i++) {
        dp[i][0] = 0;
        dp[i][1] = 1;
    }

    for (let j = 1; j <= N; j++) {
        dp[1][j] = j;
    }

    for (let i = 2; i <= K; i++) {
        for (let j = 2; j <= N; j++) {
            dp[i][j] = Infinity;
            for (let x = 1; x <= j; x++) {
                const res = 1 + Math.max(dp[i - 1][x - 1], dp[i][j - x]);
                dp[i][j] = Math.min(dp[i][j], res);
            }
        }
    }

    return dp[K][N];
};