int maximizeHappiness(int** happiness, int happinessSize, int* happinessColSize, int k) {
    int n = happinessSize;
    int dp[1 << 20][21] = {0};
    for (int mask = 1; mask < (1 << n); mask++) {
        int count = __builtin_popcount(mask);
        if (count > k) continue;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                for (int j = 0; j < n; j++) {
                    if (mask & (1 << j) && i != j) {
                        dp[mask][count] += happiness[i][j];
                    }
                }
            }
        }
    }
    int maxHappiness = 0;
    for (int mask = 0; mask < (1 << n); mask++) {
        if (__builtin_popcount(mask) == k) {
            int currentHappiness = 0;
            for (int i = 0; i < n; i++) {
                if (mask & (1 << i)) {
                    currentHappiness += dp[mask][__builtin_popcount(mask)];
                }
            }
            maxHappiness = fmax(maxHappiness, currentHappiness);
        }
    }
    return maxHappiness;
}