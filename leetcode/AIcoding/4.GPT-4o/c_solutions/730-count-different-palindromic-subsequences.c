#define MOD 1000000007

int countPalindromicSubsequences(char * s) {
    int n = strlen(s);
    long long dp[n][n];
    memset(dp, 0, sizeof(dp));

    for (int len = 1; len <= n; len++) {
        for (int i = 0; i + len - 1 < n; i++) {
            int j = i + len - 1;
            if (len == 1) {
                dp[i][j] = 1;
            } else if (s[i] == s[j]) {
                int low = i + 1, high = j - 1;
                while (low <= high && s[low] != s[i]) low++;
                while (low <= high && s[high] != s[i]) high--;
                if (low > high) {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else if (low == high) {
                    dp[i][j] = dp[i + 1][j - 1] + 1;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] - dp[low + 1][high - 1] + 2;
                }
            } else {
                dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1] + MOD) % MOD;
            }
        }
    }
    return dp[0][n - 1];
}