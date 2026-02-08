#include <stdio.h>
#include <stdlib.h>

int maxEnergyBoost(int* energyDrinkOne, int energyDrinkOneSize, int* energyDrinkTwo, int energyDrinkTwoSize) {
    if (energyDrinkOneSize != energyDrinkTwoSize) return -1;

    int n = energyDrinkOneSize;
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = energyDrinkOne[0] + energyDrinkTwo[0];

    for (int i = 1; i < n; i++) {
        dp[i] = fmax(dp[i - 1] + energyDrinkOne[i] + energyDrinkTwo[i], energyDrinkOne[i] + energyDrinkTwo[i]);
    }

    int result = dp[n - 1];
    free(dp);
    return result;
}