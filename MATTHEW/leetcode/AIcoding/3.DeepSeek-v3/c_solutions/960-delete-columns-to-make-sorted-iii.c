int minDeletionSize(char** strs, int strsSize) {
    int n = strlen(strs[0]);
    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
    }

    int max = 1;
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            int valid = 1;
            for (int k = 0; k < strsSize; k++) {
                if (strs[k][j] > strs[k][i]) {
                    valid = 0;
                    break;
                }
            }
            if (valid && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > max) {
            max = dp[i];
        }
    }

    return n - max;
}