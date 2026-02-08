#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
    int dp[m + 1][n + 1][introvertsCount + 1][extrovertsCount + 1][1 << (n)];
    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            for (int k = 0; k <= introvertsCount; k++) {
                for (int l = 0; l <= extrovertsCount; l++) {
                    for (int mask = 0; mask < (1 << (n)); mask++) {
                        dp[i][j][k][l][mask] = -1;
                    }
                }
            }
        }
    }

    int solve(int row, int col, int introverts, int extroverts, int prevMask, int m, int n, int dp[][n + 1][introvertsCount + 1][extrovertsCount + 1][1 << (n)]) {
        if (row == m) {
            return 0;
        }

        if (col == n) {
            return solve(row + 1, 0, introverts, extroverts, 0, m, n, dp);
        }

        if (dp[row][col][introverts][extroverts][prevMask] != -1) {
            return dp[row][col][introverts][extroverts][prevMask];
        }

        int ans = solve(row, col + 1, introverts, extroverts, (prevMask << 1) & ((1 << n) - 1), m, n, dp);

        if (introverts > 0) {
            int happiness = 30;
            if (col > 0 && (prevMask & 1)) {
                happiness -= 20;
            }
            if (row > 0 && (prevMask & (1 << (n - 1)))) {
                happiness -= 20;
            }
            int nextMask = ((prevMask << 1) & ((1 << n) - 1)) | 1;
            ans = fmax(ans, happiness + solve(row, col + 1, introverts - 1, extroverts, nextMask, m, n, dp));
        }

        if (extroverts > 0) {
            int happiness = 40;
            if (col > 0 && (prevMask & 1)) {
                happiness += 20;
            }
            if (row > 0 && (prevMask & (1 << (n - 1)))) {
                happiness += 20;
            }
            int nextMask = ((prevMask << 1) & ((1 << n) - 1)) | 0;
            ans = fmax(ans, happiness + solve(row, col + 1, introverts, extroverts - 1, nextMask, m, n, dp));
        }

        return dp[row][col][introverts][extroverts][prevMask] = ans;
    }

    return solve(0, 0, introvertsCount, extrovertsCount, 0, m, n, dp);
}