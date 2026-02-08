#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dieSimulator(int n, int* rollMax, int rollMaxSize) {
    const int MOD = 1e9 + 7;
    int dp[n + 1][6][16];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < 6; j++) {
            for (int k = 0; k < 16; k++) {
                dp[i][j][k] = 0;
            }
        }
    }

    for (int i = 0; i < 6; i++) {
        dp[1][i][1] = 1;
    }

    for (int i = 2; i <= n; i++) {
        for (int j = 0; j < 6; j++) {
            for (int k = 1; k <= rollMax[j]; k++) {
                if (k > i) break;
                if (k == 1) {
                    for (int l = 0; l < 6; l++) {
                        if (l != j) {
                            for (int m = 1; m <= rollMax[l]; m++) {
                                dp[i][j][k] = (dp[i][j][k] + dp[i - 1][l][m]) % MOD;
                            }
                        }
                    }
                } else {
                    dp[i][j][k] = dp[i - 1][j][k - 1];
                }
            }
        }
    }

    int total = 0;
    for (int i = 0; i < 6; i++) {
        for (int j = 1; j <= rollMax[i]; j++) {
            total = (total + dp[n][i][j]) % MOD;
        }
    }

    return total;
}