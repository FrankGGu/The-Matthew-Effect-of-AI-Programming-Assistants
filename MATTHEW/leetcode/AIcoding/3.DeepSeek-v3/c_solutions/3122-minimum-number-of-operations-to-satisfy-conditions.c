int minimumOperations(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int freq[n][10];
    memset(freq, 0, sizeof(freq));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            freq[j][grid[i][j]]++;
        }
    }

    int dp[n][10];
    for (int j = 0; j < n; j++) {
        for (int d = 0; d < 10; d++) {
            dp[j][d] = m - freq[j][d];
        }
    }

    for (int j = 1; j < n; j++) {
        int min1 = INT_MAX, min2 = INT_MAX;
        int min1_d = -1;

        for (int d = 0; d < 10; d++) {
            if (dp[j-1][d] < min1) {
                min2 = min1;
                min1 = dp[j-1][d];
                min1_d = d;
            } else if (dp[j-1][d] < min2) {
                min2 = dp[j-1][d];
            }
        }

        for (int d = 0; d < 10; d++) {
            if (d != min1_d) {
                dp[j][d] += min1;
            } else {
                dp[j][d] += min2;
            }
        }
    }

    int res = INT_MAX;
    for (int d = 0; d < 10; d++) {
        if (dp[n-1][d] < res) {
            res = dp[n-1][d];
        }
    }
    return res;
}