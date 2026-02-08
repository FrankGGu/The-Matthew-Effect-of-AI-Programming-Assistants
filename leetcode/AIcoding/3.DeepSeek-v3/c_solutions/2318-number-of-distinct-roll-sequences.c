int distinctSequences(int n) {
    if (n == 1) return 6;

    int MOD = 1000000007;
    long long dp[10001][7][7] = {0};

    for (int i = 1; i <= 6; i++) {
        for (int j = 1; j <= 6; j++) {
            if (i != j && gcd(i, j) == 1) {
                dp[2][i][j] = 1;
            }
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 1; i <= 6; i++) {
            for (int j = 1; j <= 6; j++) {
                if (i != j && gcd(i, j) == 1) {
                    for (int k = 1; k <= 6; k++) {
                        if (k != i && k != j && gcd(k, j) == 1) {
                            dp[len][j][i] = (dp[len][j][i] + dp[len-1][k][j]) % MOD;
                        }
                    }
                }
            }
        }
    }

    long long result = 0;
    for (int i = 1; i <= 6; i++) {
        for (int j = 1; j <= 6; j++) {
            result = (result + dp[n][i][j]) % MOD;
        }
    }

    return result;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}