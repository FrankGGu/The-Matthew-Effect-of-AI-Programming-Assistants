int minDeletionSize(char ** strs, int strsSize) {
    int cols = strlen(strs[0]);
    int dp[cols];
    memset(dp, 0, sizeof(dp));

    for (int j = 0; j < cols; j++) {
        for (int i = 1; i < strsSize; i++) {
            if (strs[i][j] < strs[i - 1][j]) {
                dp[j] = 1;
                break;
            }
        }
    }

    int count = 0;
    for (int j = 0; j < cols; j++) {
        if (dp[j] == 1) count++;
    }
    return count;
}