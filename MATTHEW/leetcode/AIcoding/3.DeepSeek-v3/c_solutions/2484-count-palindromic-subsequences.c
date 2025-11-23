int countPalindromicSubsequences(char* s) {
    int n = strlen(s);
    int mod = 1000000007;

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        memset(dp[i], 0, n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j]) {
                int left = i + 1;
                int right = j - 1;
                while (left <= right && s[left] != s[i]) left++;
                while (left <= right && s[right] != s[i]) right--;

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
            dp[i][j] = dp[i][j] < 0 ? dp[i][j] + mod : dp[i][j] % mod;
        }
    }

    int result = dp[0][n-1];
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}