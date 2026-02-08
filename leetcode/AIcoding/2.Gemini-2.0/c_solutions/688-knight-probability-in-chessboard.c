#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double knightProbability(int n, int k, int row, int column) {
    double dp[k + 1][n][n];
    int dx[] = {-2, -2, -1, -1, 1, 1, 2, 2};
    int dy[] = {-1, 1, -2, 2, -2, 2, -1, 1};

    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < n; j++) {
            for (int l = 0; l < n; l++) {
                dp[i][j][l] = 0.0;
            }
        }
    }

    dp[0][row][column] = 1.0;

    for (int move = 1; move <= k; move++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int d = 0; d < 8; d++) {
                    int prev_x = i - dx[d];
                    int prev_y = j - dy[d];

                    if (prev_x >= 0 && prev_x < n && prev_y >= 0 && prev_y < n) {
                        dp[move][i][j] += dp[move - 1][prev_x][prev_y] / 8.0;
                    }
                }
            }
        }
    }

    double total_probability = 0.0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            total_probability += dp[k][i][j];
        }
    }

    return total_probability;
}