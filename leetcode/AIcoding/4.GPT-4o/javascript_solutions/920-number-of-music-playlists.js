var countPlaylists = function(N, L, K) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: L + 1 }, () => Array(N + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= L; i++) {
        for (let j = 1; j <= N; j++) {
            dp[i][j] = (dp[i - 1][j - 1] * (N - j + 1)) % MOD; // add a new song
            if (j > K) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j] * (j - K)) % MOD; // replay a song
            }
        }
    }

    return dp[L][N];
};