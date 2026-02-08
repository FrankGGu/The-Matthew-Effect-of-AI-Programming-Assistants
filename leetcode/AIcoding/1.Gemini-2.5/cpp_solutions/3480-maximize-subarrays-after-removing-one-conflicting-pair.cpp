#include <vector>
#include <unordered_map>
#include <algorithm> // For std::max

class Solution {
public:
    int maximizeSubarraysAfterRemovingOneConflictingPair(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        // dp[i][0]: maximum non-overlapping conflicting pairs in nums[0...i-1] without removing any pair.
        // dp[i][1]: maximum non-overlapping conflicting pairs in nums[0...i-1] after removing exactly one pair.
        // Using n+1 size for 1-based indexing for dp states, where dp[k] refers to prefix of length k (nums[0...k-1]).
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(2, 0));

        // Initialize dp[0][1] to a very small negative number to signify an invalid state.
        // It's impossible to have one removal in an empty prefix that results in a valid count.
        // Any value that cannot be reached by a valid count (which are non-negative) will work.
        const int INVALID_STATE = -1e9; 
        dp[0][1] = INVALID_STATE; 

        std::unordered_map<int, int> last_seen; // Stores value -> last seen 0-indexed position

        for (int i = 0; i < n; ++i) {
            int current_idx_plus_1 = i + 1; // 1-indexed position for dp array

            // Option 1: Don't use nums[i] as the right end of any pair.
            // Inherit counts from the previous state (prefix of length i).
            dp[current_idx_plus_1][0] = dp[current_idx_plus_1 - 1][0];
            dp[current_idx_plus_1][1] = dp[current_idx_plus_1 - 1][1];

            // Check if nums[i] forms a conflicting pair with a previous element.
            if (last_seen.count(nums[i])) {
                int j = last_seen[nums[i]]; // j is the 0-indexed start of the pair [j, i]
                int prev_prefix_len = j;    // Length of prefix before j (nums[0...j-1]), for dp[j]

                // Update dp[current_idx_plus_1][0] (no removal)
                // We can form pair [j, i]. Add 1 to the count from before index j (dp[j][0]).
                dp[current_idx_plus_1][0] = std::max(dp[current_idx_plus_1][0], dp[prev_prefix_len][0] + 1);

                // Update dp[current_idx_plus_1][1] (one removal)
                // Option A: The current pair [j, i] IS the one we remove.
                // We take the count of pairs from before index j, where no removal has happened yet (dp[j][0]).
                dp[current_idx_plus_1][1] = std::max(dp[current_idx_plus_1][1], dp[prev_prefix_len][0]);

                // Option B: The current pair [j, i] is NOT the removed pair, but a previous pair was removed.
                // We take the count of pairs from before index j, where one removal has already happened (dp[j][1]), and add 1 for [j, i].
                // This is only valid if dp[j][1] represents a reachable state (not INVALID_STATE).
                if (dp[prev_prefix_len][1] != INVALID_STATE) {
                    dp[current_idx_plus_1][1] = std::max(dp[current_idx_plus_1][1], dp[prev_prefix_len][1] + 1);
                }
            }

            // Update the last seen index for nums[i]
            last_seen[nums[i]] = i;
        }

        // The problem asks for "at most one conflicting pair".
        // This means we can either remove zero pairs (represented by dp[n][0])
        // or remove exactly one pair (represented by dp[n][1]).
        // If dp[n][1] is INVALID_STATE, it means no valid sequence with one removal was found,
        // and max() will correctly pick dp[n][0] if it's greater (or 0 if dp[n][0] is also 0).
        return std::max(dp[n][0], dp[n][1]);
    }
};