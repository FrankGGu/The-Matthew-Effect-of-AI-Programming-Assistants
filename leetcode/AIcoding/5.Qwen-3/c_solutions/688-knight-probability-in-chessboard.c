#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double knightProbability(int n, int k, int row, int col) {
    double dp[100][100];
    int dir[8][2] = {{-1, -2}, {-2, -1}, {-2, 1}, {-1, 2}, {1, 2}, {2, 1}, {2, -1}, {1, -2}};

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 1.0;
        }
    }

    for (int step = 1; step <= k; step++) {
        double next[100][100] = {0};
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int d = 0; d < 8; d++) {
                    int ni = i + dir[d][0];
                    int nj = j + dir[d][1];
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        next[i][j] += dp[ni][nj] / 8.0;
                    }
                }
            }
        }
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = next[i][j];
            }
        }
    }

    return dp[row][col];
}