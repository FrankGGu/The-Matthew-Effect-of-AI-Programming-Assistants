#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        const int MAX_VAL = 200;
        const int INF = n + 1; // A value larger than any possible number of changes

        // dp[g][v] stores the minimum number of changes for the prefix nums[0...i]
        // such that nums[i] is changed to value 'v' and belongs to group 'g'.
        // g can be 1, 2, or 3.
        std::vector<std::vector<int>> dp(4, std::vector<int>(MAX_VAL + 1, INF));

        // Initialize for the first element nums[0]
        // The first element can start any of the three groups.
        for (int v = 1; v <= MAX_VAL; ++v) {
            dp[1][v] = (nums[0] != v);
            dp[2][v] = (nums[0] != v);
            dp[3][v] = (nums[0] != v);
        }

        // Iterate through the rest of the elements
        for (int i = 1; i < n; ++i) {
            std::vector<std::vector<int>> new_dp(4, std::vector<int>(MAX_VAL + 1, INF));

            for (int g = 1; g <= 3; ++g) {
                int min_val_from_same_group = INF; // Minimum changes ending in group 'g' with value <= current 'v'
                int min_val_from_prev_group = INF; // Minimum changes ending in group 'g-1' with value <= current 'v'

                for (int v = 1; v <= MAX_VAL; ++v) {
                    int cost = (nums[i] != v);

                    // Option 1: nums[i] extends group 'g'
                    // The previous element (nums[i-1]) must have been in group 'g' and its value <= 'v'.
                    min_val_from_same_group = std::min(min_val_from_same_group, dp[g][v]);
                    new_dp[g][v] = std::min(new_dp[g][v], min_val_from_same_group + cost);

                    // Option 2: nums[i] starts group 'g'
                    // The previous element (nums[i-1]) must have been in group 'g-1' and its value <= 'v'.
                    if (g > 1) {
                        min_val_from_prev_group = std::min(min_val_from_prev_group, dp[g-1][v]);
                        new_dp[g][v] = std::min(new_dp[g][v], min_val_from_prev_group + cost);
                    }
                }
            }
            dp = new_dp; // Update dp table for the current element
        }

        // The final answer is the minimum changes among all possible ending states
        int result = INF;
        for (int g = 1; g <= 3; ++g) {
            for (int v = 1; v <= MAX_VAL; ++v) {
                result = std::min(result, dp[g][v]);
            }
        }
        return result;
    }
};