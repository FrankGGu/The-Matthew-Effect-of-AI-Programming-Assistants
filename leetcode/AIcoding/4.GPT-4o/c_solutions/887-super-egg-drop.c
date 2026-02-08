int superEggDrop(int K, int N) {
    int dp[N + 1][K + 1];
    for (int i = 0; i <= K; i++) dp[0][i] = 0;
    for (int i = 0; i <= N; i++) dp[i][1] = i;

    for (int i = 1; i <= N; i++) {
        for (int j = 2; j <= K; j++) {
            dp[i][j] = i; 
            for (int x = 1; x <= i; x++) {
                int res = 1 + (dp[x - 1][j - 1] > dp[i - x][j] ? dp[x - 1][j - 1] : dp[i - x][j]);
                if (res < dp[i][j]) {
                    dp[i][j] = res;
                }
            }
        }
    }
    return dp[N][K];
}