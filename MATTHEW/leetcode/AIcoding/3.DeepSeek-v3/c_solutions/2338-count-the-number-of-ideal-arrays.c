int idealArrays(int n, int maxValue) {
    const int MOD = 1e9 + 7;

    // Precompute divisors for each number
    int divisors[maxValue + 1][15]; // 15 is enough since 2^14 > 10000
    int divisorCount[maxValue + 1];

    for (int i = 0; i <= maxValue; i++) {
        divisorCount[i] = 0;
    }

    for (int i = 1; i <= maxValue; i++) {
        for (int j = i; j <= maxValue; j += i) {
            divisors[j][divisorCount[j]++] = i;
        }
    }

    // DP for sequences of length k ending with value i
    int dp[15][maxValue + 1];
    for (int i = 0; i < 15; i++) {
        for (int j = 0; j <= maxValue; j++) {
            dp[i][j] = 0;
        }
    }

    // Initialize for length 1
    for (int i = 1; i <= maxValue; i++) {
        dp[1][i] = 1;
    }

    // Fill DP table
    for (int len = 2; len < 15; len++) {
        for (int i = 1; i <= maxValue; i++) {
            for (int d = 0; d < divisorCount[i]; d++) {
                int prev = divisors[i][d];
                if (prev < i) {
                    dp[len][i] = (dp[len][i] + dp[len - 1][prev]) % MOD;
                }
            }
        }
    }

    // Precompute combinations C(n-1, k-1)
    long long comb[n + 1][15];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 15; j++) {
            comb[i][j] = 0;
        }
    }

    comb[0][0] = 1;
    for (int i = 1; i <= n; i++) {
        comb[i][0] = 1;
        for (int j = 1; j < 15 && j <= i; j++) {
            comb[i][j] = (comb[i - 1][j] + comb[i - 1][j - 1]) % MOD;
        }
    }

    // Calculate final answer
    long long result = 0;
    for (int len = 1; len < 15 && len <= n; len++) {
        for (int i = 1; i <= maxValue; i++) {
            result = (result + dp[len][i] * comb[n - 1][len - 1]) % MOD;
        }
    }

    return result;
}