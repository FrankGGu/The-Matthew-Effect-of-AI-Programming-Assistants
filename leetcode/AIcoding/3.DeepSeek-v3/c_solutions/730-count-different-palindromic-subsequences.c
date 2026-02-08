int countPalindromicSubsequences(char* S) {
    int n = strlen(S);
    long mod = 1e9 + 7;
    long dp[n][n];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (S[i] == S[j]) {
                int left = i + 1;
                int right = j - 1;
                while (left <= right && S[left] != S[i]) left++;
                while (left <= right && S[right] != S[i]) right--;

                if (left > right) {
                    dp[i][j] = dp[i+1][j-1] * 2 + 2;
                } else if (left == right) {
                    dp[i][j] = dp[i+1][j-1] * 2 + 1;
                } else {
                    dp[i][j] = dp[i+1][j-1] * 2 - dp[left+1][right-1];
                }
            } else {
                dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1];
            }
            dp[i][j] = (dp[i][j] + mod) % mod;
        }
    }

    return dp[0][n-1];
}