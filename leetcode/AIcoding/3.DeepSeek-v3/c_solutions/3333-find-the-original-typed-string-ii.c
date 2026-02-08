int possibleStringCount(char* word, int k) {
    int n = strlen(word);
    long long mod = 1000000007;
    long long dp[n+1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k && i - j >= 0; j++) {
            if (j == 1) {
                dp[i] = (dp[i] + dp[i-1]) % mod;
            } else {
                int len = j;
                int valid = 1;
                for (int p = 0; p < len/2; p++) {
                    if (word[i-len+p] != word[i-len/2+p]) {
                        valid = 0;
                        break;
                    }
                }
                if (valid) {
                    dp[i] = (dp[i] + dp[i-len]) % mod;
                }
            }
        }
    }

    return dp[n];
}