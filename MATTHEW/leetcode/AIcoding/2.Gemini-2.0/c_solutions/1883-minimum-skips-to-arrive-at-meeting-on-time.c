#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSkips(int* dist, int distSize, int speed, int hoursBefore) {
    int n = distSize;
    long long dp[n + 1][n + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 1e18;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= i; j++) {
            long long time_without_skip = dp[i - 1][j] + dist[i - 1];
            long long time_with_skip = (time_without_skip + speed - 1) / speed * speed;
            dp[i][j] = time_with_skip;

            if (j > 0) {
                long long time_with_skip_opt = dp[i - 1][j - 1] + dist[i - 1];
                dp[i][j] = (dp[i][j] < time_with_skip_opt) ? dp[i][j] : time_with_skip_opt;
            }
        }
    }

    for (int j = 0; j <= n; j++) {
        if (dp[n][j] <= (long long)hoursBefore * speed) {
            return j;
        }
    }

    return -1;
}