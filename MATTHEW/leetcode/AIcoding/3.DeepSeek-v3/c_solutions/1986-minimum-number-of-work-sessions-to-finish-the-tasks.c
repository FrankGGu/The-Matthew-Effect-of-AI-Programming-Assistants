int minSessions(int* tasks, int tasksSize, int sessionTime) {
    int n = tasksSize;
    int dp[1 << n];
    int time[1 << n];

    for (int mask = 0; mask < (1 << n); mask++) {
        dp[mask] = n;
        time[mask] = 0;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                sum += tasks[i];
            }
        }
        if (sum <= sessionTime) {
            dp[mask] = 1;
            time[mask] = sum;
        }
    }

    for (int mask = 1; mask < (1 << n); mask++) {
        for (int submask = mask; submask > 0; submask = (submask - 1) & mask) {
            if (submask == mask) continue;
            int other = mask ^ submask;
            if (time[submask] + time[other] <= sessionTime) {
                if (dp[mask] > dp[submask] + dp[other] - 1) {
                    dp[mask] = dp[submask] + dp[other] - 1;
                    time[mask] = time[submask] + time[other];
                } else if (dp[mask] == dp[submask] + dp[other] - 1) {
                    if (time[mask] > time[submask] + time[other]) {
                        time[mask] = time[submask] + time[other];
                    }
                }
            } else {
                if (dp[mask] > dp[submask] + dp[other]) {
                    dp[mask] = dp[submask] + dp[other];
                    time[mask] = time[submask] + time[other];
                } else if (dp[mask] == dp[submask] + dp[other]) {
                    if (time[mask] > time[submask] + time[other]) {
                        time[mask] = time[submask] + time[other];
                    }
                }
            }
        }
    }

    return dp[(1 << n) - 1];
}