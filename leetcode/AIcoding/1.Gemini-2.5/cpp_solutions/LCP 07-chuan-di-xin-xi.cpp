#include <vector>
#include <numeric>

class Solution {
public:
    int numWays(int n, std::vector<std::vector<int>>& relation, int k) {
        std::vector<int> dp(n, 0);
        dp[0] = 1;

        for (int i = 0; i < k; ++i) {
            std::vector<int> next_dp(n, 0);
            for (const auto& rel : relation) {
                int src = rel[0];
                int dst = rel[1];
                next_dp[dst] += dp[src];
            }
            dp = next_dp;
        }

        return dp[n - 1];
    }
};