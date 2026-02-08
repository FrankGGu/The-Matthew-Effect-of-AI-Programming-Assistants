bool canConstruct(char *bottom, int bottomSize, char **allowed, int allowedSize) {
    int dp[bottomSize + 1][1 << (bottomSize + 1)];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int i = 0; i < bottomSize; i++) {
        for (int j = 0; j < (1 << (bottomSize + 1)); j++) {
            if (dp[i][j]) {
                for (int k = 0; k < allowedSize; k++) {
                    if ((allowed[k][0] == bottom[i]) && (allowed[k][1] == bottom[i + 1])) {
                        dp[i + 1][j | (1 << (i + 1))] = 1;
                    }
                }
            }
        }
    }

    return dp[bottomSize - 1][(1 << bottomSize) - 1];
}