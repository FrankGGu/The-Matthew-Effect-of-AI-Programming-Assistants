#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[51][101][51];
int n, m, k;
int MOD = 1000000007;

int solve(int idx, int maxSoFar, int remaining) {
    if (idx == n) {
        if (remaining == 0) {
            return 1;
        } else {
            return 0;
        }
    }

    if (dp[idx][maxSoFar][remaining] != -1) {
        return dp[idx][maxSoFar][remaining];
    }

    int ans = 0;
    for (int i = 1; i <= m; i++) {
        if (i > maxSoFar) {
            if (remaining > 0) {
                ans = (ans + solve(idx + 1, i, remaining - 1)) % MOD;
            }
        } else {
            ans = (ans + solve(idx + 1, maxSoFar, remaining)) % MOD;
        }
    }

    return dp[idx][maxSoFar][remaining] = ans;
}

int numOfArrays(int n_in, int m_in, int k_in) {
    n = n_in;
    m = m_in;
    k = k_in;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            for (int l = 0; l <= k; l++) {
                dp[i][j][l] = -1;
            }
        }
    }

    return solve(0, 0, k);
}