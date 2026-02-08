int maxEnergy(int* energy, int energySize, int* action, int actionSize) {
    int dp[energySize + 1];
    dp[0] = 0;

    for (int i = 1; i <= energySize; i++) {
        dp[i] = dp[i - 1];
        if (i - 1 >= 0 && action[i - 1] == 1) {
            dp[i] = dp[i] > dp[i - 1] + energy[i - 1] ? dp[i] : dp[i - 1] + energy[i - 1];
        }
        if (i - 1 >= 0 && action[i - 1] == 2 && i >= 2) {
            dp[i] = dp[i] > dp[i - 2] + energy[i - 1] ? dp[i] : dp[i - 2] + energy[i - 1];
        }
    }

    return dp[energySize];
}