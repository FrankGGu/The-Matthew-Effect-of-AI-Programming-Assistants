long long maximumStrength(int* nums, int numsSize, int k) {
    long long dp[2][k + 1][2];
    for (int i = 0; i <= k; i++) {
        dp[0][i][0] = dp[0][i][1] = -1e18;
    }
    dp[0][0][0] = 0;

    for (int i = 0; i < numsSize; i++) {
        int cur = (i + 1) % 2;
        int prev = i % 2;
        for (int j = 0; j <= k; j++) {
            dp[cur][j][0] = dp[cur][j][1] = -1e18;
        }

        for (int j = 0; j <= k; j++) {
            if (dp[prev][j][0] != -1e18) {
                dp[cur][j][0] = (dp[cur][j][0] > dp[prev][j][0]) ? dp[cur][j][0] : dp[prev][j][0];
            }
            if (dp[prev][j][1] != -1e18) {
                dp[cur][j][0] = (dp[cur][j][0] > dp[prev][j][1]) ? dp[cur][j][0] : dp[prev][j][1];
            }

            if (j < k) {
                long long mul = (j % 2 == 0) ? (k - j) : -(k - j);
                long long add = mul * nums[i];

                if (dp[prev][j][0] != -1e18) {
                    long long val = dp[prev][j][0] + add;
                    if (dp[cur][j + 1][1] < val) {
                        dp[cur][j + 1][1] = val;
                    }
                }
                if (dp[prev][j][1] != -1e18) {
                    long long val = dp[prev][j][1] + add;
                    if (dp[cur][j + 1][1] < val) {
                        dp[cur][j + 1][1] = val;
                    }
                }
                if (dp[prev][j + 1][1] != -1e18) {
                    long long val = dp[prev][j + 1][1] + add;
                    if (dp[cur][j + 1][1] < val) {
                        dp[cur][j + 1][1] = val;
                    }
                }
            }
        }
    }

    int last = numsSize % 2;
    long long res = dp[last][k][0] > dp[last][k][1] ? dp[last][k][0] : dp[last][k][1];
    return res;
}