#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxStudents(char** seats, int seatsSize, int* seatsColSize) {
    int m = seatsSize;
    int n = seatsColSize[0];
    int dp[m + 1][1 << n];
    memset(dp, -1, sizeof(dp));
    dp[0][0] = 0;

    for (int i = 1; i <= m; i++) {
        for (int mask = 0; mask < (1 << n); mask++) {
            int valid = 1;
            int count = 0;
            for (int j = 0; j < n; j++) {
                if ((mask >> j) & 1) {
                    count++;
                    if (seats[i - 1][j] == '#') {
                        valid = 0;
                        break;
                    }
                    if (j > 0 && ((mask >> (j - 1)) & 1)) {
                        valid = 0;
                        break;
                    }
                }
            }
            if (!valid) continue;

            for (int prevMask = 0; prevMask < (1 << n); prevMask++) {
                if (dp[i - 1][prevMask] == -1) continue;

                int compatible = 1;
                for (int j = 0; j < n; j++) {
                    if ((mask >> j) & 1) {
                        if (j > 0 && ((prevMask >> (j - 1)) & 1)) {
                            compatible = 0;
                            break;
                        }
                        if (j < n - 1 && ((prevMask >> (j + 1)) & 1)) {
                            compatible = 0;
                            break;
                        }
                    }
                }
                if (compatible) {
                    dp[i][mask] = (dp[i][mask] > dp[i - 1][prevMask] + count) ? dp[i][mask] : (dp[i - 1][prevMask] + count);
                }
            }
        }
    }

    int max = 0;
    for (int mask = 0; mask < (1 << n); mask++) {
        max = (max > dp[m][mask]) ? max : dp[m][mask];
    }

    return max;
}