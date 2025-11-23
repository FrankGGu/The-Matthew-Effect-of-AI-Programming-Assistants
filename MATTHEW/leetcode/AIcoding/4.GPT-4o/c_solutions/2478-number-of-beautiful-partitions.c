#define MOD 1000000007

long long dp[101][101][2];

int beautifulPartitions(char *s, int k, int minLength) {
    int n = strlen(s);
    if (s[0] == '2' || s[n - 1] == '1') return 0;

    dp[0][0][0] = dp[0][0][1] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int l = 0; l < i; l++) {
                if (s[l] == '1') {
                    dp[i][j][0] = (dp[i][j][0] + dp[l][j - 1][1]) % MOD;
                }
                if (s[l] == '2') {
                    dp[i][j][1] = (dp[i][j][1] + dp[l][j - 1][0]) % MOD;
                }
            }
        }
    }

    long long result = (dp[n][k][0] + dp[n][k][1]) % MOD;
    return result;
}