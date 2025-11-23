int maximumTotalReward(int* rewards, int rewardsSize, int k) {
    int total = 0;
    for (int i = 0; i < rewardsSize; i++) {
        total += rewards[i];
    }
    return total + k;
}