#include <vector>
#include <algorithm>
#include <bitset>

class Solution {
public:
    int maximumTotalReward(std::vector<int>& reward) {
        std::sort(reward.begin(), reward.end());

        // Remove duplicates to optimize iterations.
        // If a reward value appears multiple times, processing it more than once
        // for the bitset does not change the set of achievable sums,
        // as the condition "reward[i] > current_total" means we can only use it once
        // to increment a specific current_total.
        reward.erase(std::unique(reward.begin(), reward.end()), reward.end());

        // The maximum possible total reward is strictly less than 2 * max_reward_value.
        // Let M be the maximum value in the reward array.
        // If we have an achievable sum S, and we add reward R, then S_new = S + R.
        // The condition is R > S.
        // This implies S_new = S + R > S + S = 2S.
        // Also, R <= M, so S_new = S + R <= S + M.
        // Since S < R, S < M.
        // Thus, S_new < M + M = 2M.
        // Given max reward[i] is 2000, the maximum possible sum is strictly less than 4000.
        // So, a bitset size of 4001 (for indices 0 to 4000) is sufficient.
        const int MAX_POSSIBLE_REWARD_SUM = 4001; 
        std::bitset<MAX_POSSIBLE_REWARD_SUM> dp;

        // Initially, a total reward of 0 is achievable.
        dp[0] = 1;

        for (int r : reward) {
            // Iterate backwards through all possible current sums 's'.
            // This ensures that when we set dp[s + r] = 1, we are using the 's'
            // value from the state *before* considering the current reward 'r'.
            // If we iterated forwards, dp[s + r] might be set, and then later
            // in the same loop iteration, this newly set dp[s + r] could be used
            // as 's' to add 'r' again, which is incorrect.
            for (int s = MAX_POSSIBLE_REWARD_SUM - 1; s >= 0; --s) {
                if (dp[s] && s < r) {
                    // If sum 's' is achievable and the current reward 'r' is greater than 's',
                    // then 's + r' becomes an achievable total reward.
                    // Ensure 's + r' does not exceed the bitset bounds.
                    if (s + r < MAX_POSSIBLE_REWARD_SUM) {
                        dp[s + r] = 1;
                    }
                }
            }
        }

        // After processing all rewards, the largest index 's' for which dp[s] is true
        // is the maximum total reward achievable.
        for (int s = MAX_POSSIBLE_REWARD_SUM - 1; s >= 0; --s) {
            if (dp[s]) {
                return s;
            }
        }

        // This line should theoretically not be reached, as dp[0] is always 1,
        // guaranteeing at least a return of 0.
        return 0; 
    }
};