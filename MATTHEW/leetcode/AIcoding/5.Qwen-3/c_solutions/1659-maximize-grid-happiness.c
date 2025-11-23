#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxGridHappiness(int m, int n, int k) {
    int dp[101][101][101][2];
    int next[101][101][101][2];
    int pre[101][101][101][2];
    int cur[101][101][101][2];

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            for (int a = 0; a <= k; a++) {
                for (int b = 0; b <= 1; b++) {
                    dp[i][j][a][b] = 0;
                    next[i][j][a][b] = 0;
                    pre[i][j][a][b] = 0;
                    cur[i][j][a][b] = 0;
                }
            }
        }
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            for (int a = 0; a <= k; a++) {
                for (int b = 0; b <= 1; b++) {
                    if (i == 1 && j == 1) {
                        dp[i][j][a][b] = 0;
                    } else {
                        dp[i][j][a][b] = -1;
                    }
                }
            }
        }
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            for (int a = 0; a <= k; a++) {
                for (int b = 0; b <= 1; b++) {
                    for (int c = 0; c <= 1; c++) {
                        for (int d = 0; d <= 1; d++) {
                            if (i == 1 && j == 1) {
                                if (c == 1) {
                                    if (a >= 1) {
                                        dp[i][j][a][b] = 1;
                                    }
                                } else {
                                    dp[i][j][a][b] = 0;
                                }
                            } else {
                                int prev = dp[i - 1][j][a][d];
                                if (prev != -1) {
                                    int curr = 0;
                                    if (c == 1) {
                                        curr += 1;
                                        if (d == 1) {
                                            curr += 1;
                                        }
                                        if (b == 1) {
                                            curr += 1;
                                        }
                                    }
                                    if (prev + curr > dp[i][j][a][b]) {
                                        dp[i][j][a][b] = prev + curr;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    return dp[m][n][k][1];
}