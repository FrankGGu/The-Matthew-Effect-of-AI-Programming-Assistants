#include <stdlib.h>
#include <limits.h>

int maximumEnergy(int* energy, int energySize, int k) {
    int* dp = (int*)malloc(energySize * sizeof(int));
    int max_energy = INT_MIN;

    for (int i = energySize - 1; i >= 0; --i) {
        dp[i] = energy[i];
        if (i + k < energySize) {
            dp[i] += dp[i + k];
        }
        if (dp[i] > max_energy) {
            max_energy = dp[i];
        }
    }

    free(dp);
    return max_energy;
}