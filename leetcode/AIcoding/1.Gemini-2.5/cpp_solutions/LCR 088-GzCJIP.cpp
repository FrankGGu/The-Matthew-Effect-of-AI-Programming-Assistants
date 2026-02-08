#include <vector>
#include <algorithm>

class Solution {
public:
    int minCostClimbingStairs(std::vector<int>& cost) {
        int n = cost.size();

        // dp2 represents dp[i+2]
        // dp1 represents dp[i+1]
        // Initialize for the base cases beyond the array
        int dp2 = 0; // Corresponds to dp[n+1], cost to reach top from n+1 (already at top)
        int dp1 = 0; // Corresponds to dp[n], cost to reach top from n (already at top)

        // Iterate from the second to last step down to the first step (index 0)
        for (int i = n - 1; i >= 0; --i) {
            int current_dp_value = cost[i] + std::min(dp1, dp2);
            dp2 = dp1;
            dp1 = current_dp_value;
        }

        // The minimum cost to reach the top can be achieved by starting at step 0 (dp1)
        // or starting at step 1 (dp2, which holds the value of dp[1] after the loop)
        return std::min(dp1, dp2);
    }
};