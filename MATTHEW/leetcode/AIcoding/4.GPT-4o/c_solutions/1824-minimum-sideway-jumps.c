int minSideJumps(int* obstacles, int obstaclesSize) {
    int dp[3] = {1, 0, 1};
    for (int i = 1; i < obstaclesSize; i++) {
        int new_dp[3] = {INT_MAX, INT_MAX, INT_MAX};
        for (int j = 0; j < 3; j++) {
            if (obstacles[i] != j + 1) {
                new_dp[j] = dp[j];
                if (j > 0) new_dp[j] = fmin(new_dp[j], dp[j - 1] + 1);
                if (j < 2) new_dp[j] = fmin(new_dp[j], dp[j + 1] + 1);
            }
        }
        dp[0] = new_dp[0];
        dp[1] = new_dp[1];
        dp[2] = new_dp[2];
    }
    return dp[1];
}