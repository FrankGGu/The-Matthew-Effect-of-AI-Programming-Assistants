int minSessions(int* tasks, int tasksSize, int sessionTime) {
    int maxMask = 1 << tasksSize;
    int dp[maxMask];
    for (int i = 0; i < maxMask; i++) {
        dp[i] = 17; // more than the max possible sessions
    }
    dp[0] = 0;

    for (int mask = 0; mask < maxMask; mask++) {
        int currentTime = 0;
        for (int i = 0; i < tasksSize; i++) {
            if (mask & (1 << i)) {
                currentTime += tasks[i];
            }
        }
        if (currentTime < sessionTime) {
            for (int nextMask = 0; nextMask < maxMask; nextMask++) {
                if ((nextMask & mask) == 0) {
                    int newMask = nextMask | mask;
                    int newTime = 0;
                    for (int j = 0; j < tasksSize; j++) {
                        if (nextMask & (1 << j)) {
                            newTime += tasks[j];
                        }
                    }
                    if (newTime <= sessionTime) {
                        dp[newMask] = dp[newMask] < dp[mask] ? dp[newMask] : dp[mask];
                    } else {
                        dp[newMask] = dp[newMask] < dp[mask] + 1 ? dp[newMask] : dp[mask] + 1;
                    }
                }
            }
        }
    }

    return dp[maxMask - 1];
}