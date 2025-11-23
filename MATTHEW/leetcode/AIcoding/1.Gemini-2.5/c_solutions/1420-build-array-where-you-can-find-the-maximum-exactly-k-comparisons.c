#include <stdio.h>
#include <string.h>

#define N_MAX 50
#define M_MAX 100
#define K_MAX 50

int dp[N_MAX + 1][M_MAX + 1][K_MAX + 1];
int prefix_sum_dp[N_MAX + 1][M_MAX + 1][K_MAX + 1];
const int MOD = 1e9 + 7;

int numOfArrays(int n, int m, int k) {
    memset(dp, 0, sizeof(dp));
    memset(prefix_sum_dp, 0, sizeof(prefix_sum_dp));

    for (int j = 1; j <= m; j++) {
        dp[1][j][1] = 1;
    }

    for (int comp = 1; comp <= k; comp++) {
        for (int j = 1; j <= m; j++) {
            prefix_sum_dp[1][j][comp] = (prefix_sum_dp[1][j-1][comp] + dp[1][j][comp]) % MOD;
        }
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            for (int comp = 1; comp <= k; comp++) {
                if (comp > 1) {
                    dp[i][j][comp] = (dp[i][j][comp] + prefix_sum_dp[i-1][j-1][comp-1]) % MOD;
                }

                dp[i][j][comp] = (dp[i][j][comp] + (long long)dp[i-1][j][comp] * j) % MOD;
            }
        }

        for (int comp = 1; comp <= k; comp++) {
            for (int j = 1; j <= m; j++) {
                prefix_sum_dp[i][j][comp] = (prefix_sum_dp[i][j-1][comp] + dp[i][j][comp]) % MOD;
            }
        }
    }

    int ans = 0;
    for (int j = 1; j <= m; j++) {
        ans = (ans + dp[n][j][k]) % MOD;
    }
    return ans;
}