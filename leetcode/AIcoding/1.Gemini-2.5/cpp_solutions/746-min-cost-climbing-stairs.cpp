#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int minCostClimbingStairs(std::vector<int>& cost) {
        int n = cost.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return cost[0];
        }

        // dp[i] represents the minimum cost to reach step i and pay cost[i]
        // to potentially move from it.
        // We can optimize space to O(1) by only keeping track of the last two steps.

        // prev2 stores dp[i-2]
        // prev1 stores dp[i-1]
        int prev2 = cost[0];
        int prev1 = cost[1];

        for (int i = 2; i < n; ++i) {
            int current = std::min(prev1, prev2) + cost[i];
            prev2 = prev1;
            prev1 = current;
        }

        // The minimum cost to reach the top of the floor is the minimum of
        // reaching the top from the last step (n-1) or the second to last step (n-2).
        // These correspond to prev1 (dp[n-1]) and prev2 (dp[n-2]) respectively.
        return std::min(prev1, prev2);
    }
};