#include <vector>
#include <numeric> // For std::numeric_limits
#include <algorithm> // For std::min

class Solution {
public:
    long long minCost(std::vector<int>& nums, int k) {
        int n = nums.size();

        // dp[i] will store the minimum cost to split the prefix nums[0...i-1]
        // dp array size n+1, where dp[0] is for an empty prefix (cost 0)
        std::vector<long long> dp(n + 1, std::numeric_limits<long long>::max());
        dp[0] = 0;

        // Iterate through all possible end points of the current prefix
        for (int i = 1; i <= n; ++i) {
            // For each i, we want to calculate dp[i].
            // dp[i] = min(dp[j] + cost(nums[j...i-1])) for 0 <= j < i.

            // To efficiently calculate cost(nums[j...i-1]) for all j,
            // we iterate j backwards from i-1 down to 0.
            // As j decreases, the subarray nums[j...i-1] grows to the left.

            // Using a vector for counts because nums[i] values are guaranteed
            // to be within the range [0, n-1]. This allows O(1) frequency updates.
            std::vector<int> counts(n, 0); 
            int current_trim = 0;

            for (int j = i - 1; j >= 0; --j) {
                // The current subarray being considered is nums[j...i-1]
                int element = nums[j];
                counts[element]++;

                // If the frequency of 'element' becomes 2, it means this element
                // now appears at least twice in the current subarray, so we increment
                // the count of distinct elements that appear at least twice (current_trim).
                // If its frequency was already 2 or more (e.g., 3, 4, etc.), current_trim
                // does not change, as it's still counted as one distinct element appearing multiple times.
                if (counts[element] == 2) {
                    current_trim++;
                }

                // The cost of the current subarray nums[j...i-1] is k + current_trim
                long long cost_subarray = (long long)k + current_trim;

                // Update dp[i] using the minimum cost from previous states
                // dp[j] represents the minimum cost to split nums[0...j-1]
                if (dp[j] != std::numeric_limits<long long>::max()) {
                    dp[i] = std::min(dp[i], dp[j] + cost_subarray);
                }
            }
        }

        return dp[n];
    }
};