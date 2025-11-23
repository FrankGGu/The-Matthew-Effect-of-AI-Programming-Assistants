#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_N 3

int minMoves(int grid[MAX_N][MAX_N]) {
    int zeros_x[9], zeros_y[9], stones_x[9], stones_y[9];
    int zeros_count = 0, stones_count = 0;

    for (int i = 0; i < MAX_N; i++) {
        for (int j = 0; j < MAX_N; j++) {
            if (grid[i][j] == 0) {
                zeros_x[zeros_count] = i;
                zeros_y[zeros_count] = j;
                zeros_count++;
            } else if (grid[i][j] > 1) {
                for (int k = 1; k < grid[i][j]; k++) {
                    stones_x[stones_count] = i;
                    stones_y[stones_count] = j;
                    stones_count++;
                }
                stones_x[stones_count] = i;
                stones_y[stones_count] = j;
                stones_count++;
            }
        }
    }

    int dp[1 << zeros_count];
    for (int i = 0; i < (1 << zeros_count); i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int mask = 0; mask < (1 << zeros_count); mask++) {
        if (dp[mask] == INT_MAX) continue;

        int count = 0;
        for (int i = 0; i < zeros_count; i++) {
            if ((mask & (1 << i)) != 0) {
                count++;
            }
        }

        if (count == zeros_count) continue;

        for (int i = 0; i < zeros_count; i++) {
            if ((mask & (1 << i)) == 0) {
                for (int j = 0; j < stones_count; j++) {
                    int new_mask = mask | (1 << i);
                    int moves = abs(zeros_x[i] - stones_x[j]) + abs(zeros_y[i] - stones_y[j]);
                    if (dp[mask] + moves < dp[new_mask]) {
                        dp[new_mask] = dp[mask] + moves;
                    }
                }
            }
        }
    }

    return dp[(1 << zeros_count) - 1];
}