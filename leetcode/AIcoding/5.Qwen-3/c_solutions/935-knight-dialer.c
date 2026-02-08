#include <stdio.h>
#include <stdlib.h>

int knightDialer(int n) {
    int mod = 1000000007;
    int dp[4][3];
    int next_dp[4][3];
    int moves[8][2] = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};

    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;
    dp[0][1] = 1;
    dp[0][2] = 1;
    dp[1][0] = 1;
    dp[1][2] = 1;
    dp[2][0] = 1;
    dp[2][1] = 1;
    dp[2][2] = 1;
    dp[3][0] = 1;

    for (int step = 1; step < n; step++) {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                next_dp[i][j] = 0;
            }
        }

        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                if (dp[i][j] == 0) continue;

                for (int k = 0; k < 8; k++) {
                    int ni = i + moves[k][0];
                    int nj = j + moves[k][1];

                    if (ni >= 0 && ni < 4 && nj >= 0 && nj < 3 && !(ni == 3 && nj == 1)) {
                        next_dp[ni][nj] = (next_dp[ni][nj] + dp[i][j]) % mod;
                    }
                }
            }
        }

        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                dp[i][j] = next_dp[i][j];
            }
        }
    }

    int result = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            if (!(i == 3 && j == 1)) {
                result = (result + dp[i][j]) % mod;
            }
        }
    }

    return result;
}