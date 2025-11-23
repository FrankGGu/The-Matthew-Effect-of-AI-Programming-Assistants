int minimumOperationsToMakeEqual(int x, int y) {
    if (x <= y) return y - x;

    int max_val = 10000 + 2 * (x > 10000 ? x : 10000);
    int* dp = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; i++) dp[i] = INT_MAX;

    dp[x] = 0;

    for (int i = x; i >= y; i--) {
        if (dp[i] == INT_MAX) continue;

        if (i % 11 == 0) {
            int next = i / 11;
            if (dp[next] > dp[i] + 1) {
                dp[next] = dp[i] + 1;
                if (next < i) i = next + 1;
            }
        }

        if (i % 5 == 0) {
            int next = i / 5;
            if (dp[next] > dp[i] + 1) {
                dp[next] = dp[i] + 1;
                if (next < i) i = next + 1;
            }
        }

        if (i - 1 >= 0 && dp[i - 1] > dp[i] + 1) {
            dp[i - 1] = dp[i] + 1;
        }
    }

    for (int i = y; i <= max_val; i++) {
        if (dp[i] == INT_MAX) continue;

        if (i % 11 == 0) {
            int next = i / 11;
            if (dp[next] > dp[i] + 1) {
                dp[next] = dp[i] + 1;
            }
        }

        if (i % 5 == 0) {
            int next = i / 5;
            if (dp[next] > dp[i] + 1) {
                dp[next] = dp[i] + 1;
            }
        }

        if (i + 1 <= max_val && dp[i + 1] > dp[i] + 1) {
            dp[i + 1] = dp[i] + 1;
        }

        if (i - 1 >= 0 && dp[i - 1] > dp[i] + 1) {
            dp[i - 1] = dp[i] + 1;
        }
    }

    int result = dp[y];
    free(dp);
    return result;
}