#include <stdlib.h> // For qsort

static int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int sumOfPower(int* heroes, int heroesSize) {
    long long MOD = 1e9 + 7;

    // Sort the heroes array in non-decreasing order
    qsort(heroes, heroesSize, sizeof(int), compareIntegers);

    long long total_power = 0;
    // current_S represents S_i = sum_{j=0}^{i-1} (heroes[j] * 2^(i - j - 1))
    // This sum accounts for the minimum elements (heroes[j]) for subsequences
    // where heroes[i] is the maximum, and heroes[j] is chosen as the minimum.
    // The term 2^(i - j - 1) is the number of ways to choose elements between heroes[j] and heroes[i].
    long long current_S = 0; 

    for (int i = 0; i < heroesSize; ++i) {
        long long max_val = heroes[i];

        // Calculate the square of the maximum value (heroes[i])
        long long max_val_sq = (max_val * max_val) % MOD;

        // Calculate the sum of minimums for subsequences where heroes[i] is the maximum.
        // This sum is (heroes[i] + current_S) % MOD.
        // - heroes[i] accounts for the case where heroes[i] is both the minimum and maximum.
        // - current_S accounts for cases where heroes[j] (j < i) is the minimum and heroes[i] is the maximum.
        long long min_sum_term = (max_val + current_S) % MOD;

        // Add the contribution of heroes[i] as the maximum element to total_power
        // Contribution = max_val^2 * (sum of min_elements)
        long long contribution = (max_val_sq * min_sum_term) % MOD;
        total_power = (total_power + contribution) % MOD;

        // Update current_S for the next iteration (S_{i+1}) using the recurrence:
        // S_{i+1} = (heroes[i] + 2 * S_i) % MOD
        current_S = (heroes[i] + 2 * current_S) % MOD;
    }

    return (int)total_power;
}