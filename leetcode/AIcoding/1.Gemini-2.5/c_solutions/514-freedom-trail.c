#include <string.h>
#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int findRotateSteps(char *ring, char *key) {
    int n = strlen(ring);
    int m = strlen(key);

    int dp[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i < n; i++) {
        if (ring[i] == key[0]) {
            dp[0][i] = min(i, n - i) + 1;
        }
    }

    for (int j = 1; j < m; j++) {
        for (int curr_ring_idx = 0; curr_ring_idx < n; curr_ring_idx++) {
            if (ring[curr_ring_idx] == key[j]) {
                for (int prev_ring_idx = 0; prev_ring_idx < n; prev_ring_idx++) {
                    if (ring[prev_ring_idx] == key[j - 1]) {
                        if (dp[j - 1][prev_ring_idx] != INT_MAX) {
                            int diff = abs(curr_ring_idx - prev_ring_idx);
                            int rotation_steps = min(diff, n - diff);
                            dp[j][curr_ring_idx] = min(dp[j][curr_ring_idx], dp[j - 1][prev_ring_idx] + rotation_steps + 1);
                        }
                    }
                }
            }
        }
    }

    int min_total_steps = INT_MAX;
    for (int i = 0; i < n; i++) {
        min_total_steps = min(min_total_steps, dp[m - 1][i]);
    }

    return min_total_steps;
}