#define MAX_LEN 1000

int maxPartitionsAfterOperations(char* s, int k) {
    int n = strlen(s);
    int dp[MAX_LEN + 1][1 << 10];
    int dp2[MAX_LEN + 1][1 << 10];

    for (int i = 0; i <= n; i++) {
        for (int mask = 0; mask < (1 << 10); mask++) {
            dp[i][mask] = -1;
            dp2[i][mask] = -1;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        for (int mask = 0; mask < (1 << 10); mask++) {
            if (dp[i][mask] == -1) continue;

            int new_mask = mask | (1 << c);
            int cnt = __builtin_popcount(new_mask);

            if (cnt > k) {
                if (dp[i + 1][1 << c] < dp[i][mask] + 1) {
                    dp[i + 1][1 << c] = dp[i][mask] + 1;
                }
            } else {
                if (dp[i + 1][new_mask] < dp[i][mask]) {
                    dp[i + 1][new_mask] = dp[i][mask];
                }
            }

            if (dp2[i][mask] == -1) continue;

            new_mask = mask | (1 << c);
            cnt = __builtin_popcount(new_mask);

            if (cnt > k) {
                if (dp[i + 1][1 << c] < dp2[i][mask] + 1) {
                    dp[i + 1][1 << c] = dp2[i][mask] + 1;
                }
            } else {
                if (dp[i + 1][new_mask] < dp2[i][mask]) {
                    dp[i + 1][new_mask] = dp2[i][mask];
                }
            }
        }

        for (int mask = 0; mask < (1 << 10); mask++) {
            if (dp[i][mask] == -1) continue;

            for (int change = 0; change < 26; change++) {
                int new_mask = mask | (1 << change);
                int cnt = __builtin_popcount(new_mask);

                if (cnt > k) {
                    if (dp2[i + 1][1 << change] < dp[i][mask] + 1) {
                        dp2[i + 1][1 << change] = dp[i][mask] + 1;
                    }
                } else {
                    if (dp2[i + 1][new_mask] < dp[i][mask]) {
                        dp2[i + 1][new_mask] = dp[i][mask];
                    }
                }
            }
        }

        for (int mask = 0; mask < (1 << 10); mask++) {
            if (dp2[i][mask] == -1) continue;

            for (int change = 0; change < 26; change++) {
                int new_mask = mask | (1 << change);
                int cnt = __builtin_popcount(new_mask);

                if (cnt > k) {
                    if (dp2[i + 1][1 << change] < dp2[i][mask] + 1) {
                        dp2[i + 1][1 << change] = dp2[i][mask] + 1;
                    }
                } else {
                    if (dp2[i + 1][new_mask] < dp2[i][mask]) {
                        dp2[i + 1][new_mask] = dp2[i][mask];
                    }
                }
            }
        }
    }

    int ans = 0;
    for (int mask = 0; mask < (1 << 10); mask++) {
        if (dp[n][mask] > ans) ans = dp[n][mask];
        if (dp2[n][mask] > ans) ans = dp2[n][mask];
    }

    return ans + 1;
}