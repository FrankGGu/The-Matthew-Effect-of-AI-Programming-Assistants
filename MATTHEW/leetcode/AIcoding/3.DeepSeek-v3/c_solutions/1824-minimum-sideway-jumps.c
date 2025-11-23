int minSideJumps(int* obstacles, int obstaclesSize) {
    int dp[3] = {1, 0, 1};

    for (int i = 1; i < obstaclesSize; i++) {
        int next[3] = {dp[0], dp[1], dp[2]};

        if (obstacles[i] != 0) {
            next[obstacles[i] - 1] = INT_MAX - 1;
        }

        for (int j = 0; j < 3; j++) {
            if (obstacles[i] != j + 1) {
                for (int k = 0; k < 3; k++) {
                    if (obstacles[i] != k + 1 && j != k) {
                        next[j] = next[j] < dp[k] + 1 ? next[j] : dp[k] + 1;
                    }
                }
            }
        }

        dp[0] = next[0];
        dp[1] = next[1];
        dp[2] = next[2];
    }

    int min = dp[0];
    if (dp[1] < min) min = dp[1];
    if (dp[2] < min) min = dp[2];
    return min;
}