int min(int a, int b) {
    return a < b ? a : b;
}

int connectTwoGroups(int** cost, int costSize, int* costColSize) {
    int m = costSize;
    int n = *costColSize;

    int min_cost2[n];
    for (int j = 0; j < n; j++) {
        min_cost2[j] = INT_MAX;
        for (int i = 0; i < m; i++) {
            min_cost2[j] = min(min_cost2[j], cost[i][j]);
        }
    }

    int dp[1 << n];
    for (int mask = 0; mask < (1 << n); mask++) {
        dp[mask] = 0;
        for (int j = 0; j < n; j++) {
            if (mask & (1 << j)) {
                dp[mask] += min_cost2[j];
            }
        }
    }

    for (int i = 0; i < m; i++) {
        int cur[1 << n];
        for (int mask = 0; mask < (1 << n); mask++) {
            cur[mask] = INT_MAX;
        }

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int j = 0; j < n; j++) {
                int new_mask = mask | (1 << j);
                cur[new_mask] = min(cur[new_mask], dp[mask] + cost[i][j]);
            }
        }

        for (int mask = 0; mask < (1 << n); mask++) {
            dp[mask] = cur[mask];
        }
    }

    return dp[(1 << n) - 1];
}