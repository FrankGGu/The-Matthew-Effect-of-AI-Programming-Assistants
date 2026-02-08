#define MOD 1000000007

int knightDialer(int n) {
    long dp[4][3] = {0};
    long next[4][3] = {0};

    for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 4; i++) {
            if (i == 3 && j == 1) continue; // Skip 11
            dp[i][j] = 1;
        }
    }

    for (int step = 1; step < n; step++) {
        memset(next, 0, sizeof(next));
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                if (dp[i][j] == 0) continue;
                int curr = dp[i][j];

                if (i == 0) {
                    if (j > 0) next[1][j - 1] = (next[1][j - 1] + curr) % MOD;
                    if (j < 2) next[1][j + 1] = (next[1][j + 1] + curr) % MOD;
                    next[2][j] = (next[2][j] + curr) % MOD;
                } else if (i == 1) {
                    if (j > 0) next[0][j - 1] = (next[0][j - 1] + curr) % MOD;
                    if (j < 2) next[0][j + 1] = (next[0][j + 1] + curr) % MOD;
                    next[2][j] = (next[2][j] + curr) % MOD;
                    next[3][j] = (next[3][j] + curr) % MOD;
                } else if (i == 2) {
                    if (j > 0) next[0][j - 1] = (next[0][j - 1] + curr) % MOD;
                    if (j < 2) next[0][j + 1] = (next[0][j + 1] + curr) % MOD;
                    next[1][j] = (next[1][j] + curr) % MOD;
                    next[3][j] = (next[3][j] + curr) % MOD;
                } else if (i == 3) {
                    if (j > 0) next[2][j - 1] = (next[2][j - 1] + curr) % MOD;
                    if (j < 2) next[2][j + 1] = (next[2][j + 1] + curr) % MOD;
                    next[1][j] = (next[1][j] + curr) % MOD;
                }
            }
        }
        memcpy(dp, next, sizeof(dp));
    }

    long result = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            result = (result + dp[i][j]) % MOD;
        }
    }

    return result;
}