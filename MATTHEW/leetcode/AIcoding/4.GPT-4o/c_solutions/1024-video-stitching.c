int videoStitching(int** clips, int clipsSize, int* clipsColSize, int T) {
    int dp[101] = {0};
    for (int i = 1; i <= T; i++) {
        dp[i] = INT_MAX;
        for (int j = 0; j < clipsSize; j++) {
            if (clips[j][0] < i && clips[j][1] >= i) {
                dp[i] = fmin(dp[i], dp[clips[j][0]] + 1);
            }
        }
    }
    return dp[T] == INT_MAX ? -1 : dp[T];
}