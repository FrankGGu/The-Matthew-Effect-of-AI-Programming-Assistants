function superEggDrop(K, N) {
    const dp = Array.from({ length: K + 1 }, () => Array(N + 1).fill(0));

    for (let i = 1; i <= K; i++) {
        for (let j = 1; j <= N; j++) {
            dp[i][j] = dp[i][j - 1] + dp[i - 1][j - 1] + 1;
            if (dp[i][j] >= N) {
                return j;
            }
        }
    }

    return N;
}