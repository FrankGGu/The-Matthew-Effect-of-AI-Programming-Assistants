#include <vector>
#include <algorithm>
#include <bitset>

class Solution {
public:
    int maxTotalReward(std::vector<int>& rewardValues) {
        // Sort rewardValues in ascending order. This helps in the DP approach
        // by processing smaller rewards first, which makes them available
        // to satisfy the condition for subsequent larger rewards.
        std::sort(rewardValues.begin(), rewardValues.end());

        // The maximum possible reward is bounded.
        // If current reward is R, and we pick r >= R, new reward is R+r.
        // The largest possible reward value in the input is 4000.
        // If we have a current reward of R, and we pick a reward r, then r >= R.
        // The new reward is R+r. Since r <= max(rewardValues), the new reward R+r <= R + max(rewardValues).
        // Also, R <= r <= max(rewardValues).
        // So, R+r <= max(rewardValues) + max(rewardValues) = 2 * max(rewardValues).
        // Given max(rewardValues) is 4000, the maximum total reward is at most 2 * 4000 = 8000.
        // A bitset of size 8001 (for indices 0 to 8000) is sufficient.
        const int MAX_POSSIBLE_REWARD = 8000;
        std::bitset<MAX_POSSIBLE_REWARD + 1> dp;

        // Initialize dp[0] to true, as a reward of 0 is achievable initially.
        dp[0] = true;

        // Iterate through each reward value.
        for (int r : rewardValues) {
            // Iterate 'j' (representing current total reward) downwards.
            // This ensures that when dp[j+r] is set, it uses dp[j] from the state
            // before the current 'r' was considered for any sum. This correctly
            // models using each specific reward value from the input array at most once.
            for (int j = MAX_POSSIBLE_REWARD; j >= 0; --j) {
                // If 'j' is an achievable current reward
                if (dp[j]) {
                    // And 'r' can be picked (condition: r >= current_total_reward)
                    // Note: The problem description states "strictly greater", but the example
                    // implies "greater than or equal to". Following the example's logic.
                    if (r >= j) {
                        // If adding 'r' does not exceed the maximum possible reward
                        if (j + r <= MAX_POSSIBLE_REWARD) {
                            // Then 'j + r' is a new achievable reward
                            dp[j + r] = true;
                        }
                    }
                }
            }
        }

        // After processing all reward values, find the largest 'j' for which dp[j] is true.
        // This represents the maximum total reward that can be achieved.
        int max_achievable_reward = 0;
        for (int j = MAX_POSSIBLE_REWARD; j >= 0; --j) {
            if (dp[j]) {
                max_achievable_reward = j;
                break; // Found the largest, so we can stop
            }
        }

        return max_achievable_reward;
    }
};