#include <stdio.h>
#include <stdlib.h>

int maxEnergyDrunk(int* energy, int energySize) {
    int n = energySize;
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = energy[0];
    for (int i = 1; i < n; i++) {
        dp[i] = (dp[i - 1] + energy[i]) > energy[i] ? dp[i - 1] + energy[i] : energy[i];
    }
    int max = dp[0];
    for (int i = 1; i < n; i++) {
        if (dp[i] > max) {
            max = dp[i];
        }
    }
    free(dp);
    return max;
}