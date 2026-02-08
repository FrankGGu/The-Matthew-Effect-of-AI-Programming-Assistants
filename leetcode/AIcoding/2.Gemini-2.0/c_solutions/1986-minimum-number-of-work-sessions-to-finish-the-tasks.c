#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSessions(int* tasks, int tasksSize, int sessionTime) {
    int n = tasksSize;
    int dp[1 << n];
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 1;

    for (int mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] == INT_MAX) continue;

        for (int submask = 0; submask < (1 << n); submask++) {
            if ((mask & submask) != 0) continue;

            int sum = 0;
            for (int i = 0; i < n; i++) {
                if ((submask & (1 << i)) != 0) {
                    sum += tasks[i];
                }
            }

            if (sum <= sessionTime) {
                int next_mask = mask | submask;
                dp[next_mask] = fmin(dp[next_mask], dp[mask] + 1 - (next_mask == ((1 << n) - 1)));
            }
        }
    }

    return dp[(1 << n) - 1];
}