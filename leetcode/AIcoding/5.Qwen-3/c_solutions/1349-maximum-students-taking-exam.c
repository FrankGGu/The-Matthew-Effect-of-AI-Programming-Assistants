#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100

int maxStudents(char** seats, int seatsSize, int* seatsColSize) {
    int n = seatsSize;
    int m = seatsColSize[0];

    int dp[1 << m];
    int next_dp[1 << m];

    for (int i = 0; i < (1 << m); i++) {
        dp[i] = -1;
    }

    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        memset(next_dp, -1, sizeof(next_dp));

        for (int mask = 0; mask < (1 << m); mask++) {
            if (dp[mask] == -1) continue;

            for (int new_mask = 0; new_mask < (1 << m); new_mask++) {
                int valid = 1;
                for (int j = 0; j < m; j++) {
                    if ((new_mask & (1 << j)) && seats[i][j] == ' ') {
                        if ((new_mask & (1 << (j - 1))) || (new_mask & (1 << (j + 1)))) {
                            valid = 0;
                            break;
                        }
                    }
                }

                if (!valid) continue;

                int cnt = 0;
                for (int j = 0; j < m; j++) {
                    if (new_mask & (1 << j)) cnt++;
                }

                int overlap = (mask & new_mask);
                if (overlap != 0) continue;

                next_dp[new_mask] = fmax(next_dp[new_mask], dp[mask] + cnt);
            }
        }

        memcpy(dp, next_dp, sizeof(dp));
    }

    int result = 0;
    for (int i = 0; i < (1 << m); i++) {
        if (dp[i] > result) result = dp[i];
    }

    return result;
}