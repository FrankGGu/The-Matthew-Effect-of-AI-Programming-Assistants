#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int waysToReachTarget(std::vector<std::vector<int>>& types, int target) {
        long long MOD = 1e9 + 7;
        std::vector<long long> dp(target + 1, 0);
        dp[0] = 1;

        for (const auto& type : types) {
            int count = type[0];
            int points = type[1];

            int k = 1; // Represents the number of items in the current "bundle" (power of 2)
            while (count > 0) {
                int num_items_in_bundle = std::min(k, count);
                int current_bundle_points = num_items_in_bundle * points;

                // Apply 0/1 knapsack logic for this "composite" item (bundle)
                // Iterate backwards to ensure each dp[p] uses values from the previous state
                for (int p = target; p >= current_bundle_points; --p) {
                    dp[p] = (dp[p] + dp[p - current_bundle_points]) % MOD;
                }

                count -= num_items_in_bundle;
                k *= 2; // Move to the next power of 2 for the bundle size
            }
        }

        return dp[target];
    }
};