int findRotateSteps(char* ring, char* key) {
    int n = strlen(ring);
    int m = strlen(key);

    int dp[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int j = 0; j < n; j++) {
        if (ring[j] == key[0]) {
            dp[0][j] = fmin(j, n - j) + 1;
        }
    }

    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (dp[i-1][j] == INT_MAX) continue;

            for (int k = 0; k < n; k++) {
                if (ring[k] == key[i]) {
                    int diff = abs(j - k);
                    int step = fmin(diff, n - diff);
                    dp[i][k] = fmin(dp[i][k], dp[i-1][j] + step + 1);
                }
            }
        }
    }

    int result = INT_MAX;
    for (int j = 0; j < n; j++) {
        result = fmin(result, dp[m-1][j]);
    }
    return result;
}