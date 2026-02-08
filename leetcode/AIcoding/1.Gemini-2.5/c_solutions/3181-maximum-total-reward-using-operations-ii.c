#include <stdlib.h> // For qsort
#include <stdbool.h> // For bool
#include <string.h> // For memset

#define MAX_REWARD_VALUE_LIMIT 100000
#define DP_ARRAY_SIZE (2 * MAX_REWARD_VALUE_LIMIT) // Max index is DP_ARRAY_SIZE - 1
#define BITSET_WORDS (DP_ARRAY_SIZE / 64 + 1)

unsigned long long dp_bitset[BITSET_WORDS];

void set_bit(int idx) {
    if (idx < DP_ARRAY_SIZE) {
        dp_bitset[idx / 64] |= (1ULL << (idx % 64));
    }
}

bool get_bit(int idx) {
    if (idx < 0 || idx >= DP_ARRAY_SIZE) {
        return false;
    }
    return (dp_bitset[idx / 64] >> (idx % 64)) & 1ULL;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumTotalReward(int* rewardValues, int rewardValuesSize) {
    // 1. Sort rewardValues in ascending order
    qsort(rewardValues, rewardValuesSize, sizeof(int), compare);

    // 2. Remove duplicates
    if (rewardValuesSize == 0) {
        return 0;
    }
    int unique_idx = 0;
    for (int i = 1; i < rewardValuesSize; ++i) {
        if (rewardValues[i] != rewardValues[unique_idx]) {
            unique_idx++;
            rewardValues[unique_idx] = rewardValues[i];
        }
    }
    rewardValuesSize = unique_idx + 1;

    // 3. Initialize DP bitset
    // memset initializes all bits to 0 (false)
    memset(dp_bitset, 0, sizeof(dp_bitset));
    set_bit(0); // dp[0] = true, representing an initial sum of 0

    int current_max_sum = 0;

    // 4. Iterate through unique sorted reward values
    for (int i = 0; i < rewardValuesSize; ++i) {
        int r = rewardValues[i];

        // Iterate through all currently achievable sums 's' in decreasing order.
        // The condition is that 's' must be strictly less than 'r' to add 'r'.
        // Iterating 's' downwards ensures that we use dp[s] values from the previous
        // state (before considering the current 'r') when calculating dp[s+r].
        // The loop for 's' goes from `current_max_sum` down to `0`.
        // The `s < r` check inside the loop handles the condition.
        for (int s = current_max_sum; s >= 0; --s) {
            if (s < r) { // Condition: S_prev < r_i
                if (get_bit(s)) {
                    // If sum 's' is achievable, then 's + r' is also achievable
                    set_bit(s + r);
                    // Update the maximum sum found so far
                    if (s + r > current_max_sum) {
                        current_max_sum = s + r;
                    }
                }
            } else {
                // Since 's' is decreasing, if s >= r, then all subsequent smaller 's'
                // values might or might not be less than 'r'.
                // The `s < r` condition correctly filters. No further optimization needed here.
            }
        }
    }

    // The final current_max_sum is the maximum total reward
    return current_max_sum;
}