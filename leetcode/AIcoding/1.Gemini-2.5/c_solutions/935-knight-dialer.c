int knightDialer(int n) {
    if (n == 1) {
        return 10;
    }

    long long dp[10];
    long long next_dp[10];

    int MOD = 1e9 + 7;

    int moves[10][3] = {
        {4, 6, -1},
        {6, 8, -1},
        {7, 9, -1},
        {4, 8, -1},
        {0, 3, 9},
        {-1, -1, -1},
        {0, 1, 7},
        {2, 6, -1},
        {1, 3, -1},
        {2, 4, -1}
    };

    for (int i = 0; i < 10; i++) {
        dp[i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i < 10; i++) {
            next_dp[i] = 0;
        }

        for (int digit = 0; digit < 10; digit++) {
            if (dp[digit] > 0) {
                for (int i = 0; i < 3; i++) {
                    int next_digit = moves[digit][i];
                    if (next_digit != -1) {
                        next_dp[next_digit] = (next_dp[next_digit] + dp[digit]) % MOD;
                    }
                }
            }
        }
        for (int i = 0; i < 10; i++) {
            dp[i] = next_dp[i];
        }
    }

    long long total_count = 0;
    for (int i = 0; i < 10; i++) {
        total_count = (total_count + dp[i]) % MOD;
    }

    return (int)total_count;
}