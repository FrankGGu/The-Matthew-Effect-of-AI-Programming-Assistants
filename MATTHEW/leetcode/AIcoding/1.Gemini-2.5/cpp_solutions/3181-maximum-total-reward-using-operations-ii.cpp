#include <vector>
#include <algorithm>
#include <bitset>

class Solution {
public:
    int maxTotalReward(std::vector<int>& rewardValues) {
        std::sort(rewardValues.begin(), rewardValues.end());

        // The maximum possible reward is 2 * max(rewardValues[i]) - 1.
        // Given max(rewardValues[i]) is 1000, the maximum total reward is 2 * 1000 - 1 = 1999.
        // A bitset of size 2000 (indices 0 to 1999) is sufficient to store all possible rewards.
        const int MAX_POSSIBLE_REWARD_SUM = 2000; 
        std::bitset<MAX_POSSIBLE_REWARD_SUM> dp;
        dp[0] = true; // A reward of 0 is achievable by taking no rewards.

        for (int r : rewardValues) {
            // Create a mask for rewards strictly less than 'r'.
            // This mask will have bits from 0 up to r-1 set to true.
            // std::bitset<MAX_POSSIBLE_REWARD_SUM>().set() creates a bitset with all bits true.
            // Shifting it right by (MAX_POSSIBLE_REWARD_SUM - r) effectively sets bits 0 to r-1.
            std::bitset<MAX_POSSIBLE_REWARD_SUM> mask_less_than_r = 
                (std::bitset<MAX_POSSIBLE_REWARD_SUM>().set() >> (MAX_POSSIBLE_REWARD_SUM - r));

            // Update dp: if a reward 'x' is currently achievable (dp[x] is true)
            // AND 'x' is strictly less than 'r' (checked by mask_less_than_r),
            // then 'x + r' becomes a new achievable reward.
            // (dp & mask_less_than_r) isolates the achievable rewards 'x' that satisfy x < r.
            // Shifting this result left by 'r' positions gives the new achievable rewards (x + r).
            // Bitwise OR this with the current dp to include these new possibilities.
            dp |= ((dp & mask_less_than_r) << r);
        }

        // Find the largest index 'i' for which dp[i] is true. This is the maximum total reward.
        for (int i = MAX_POSSIBLE_REWARD_SUM - 1; i >= 0; --i) {
            if (dp[i]) {
                return i;
            }
        }

        return 0; // Should not be reached as dp[0] is always true.
    }
};