#include <vector>
#include <algorithm>

class Solution {
public:
    int paintWalls(std::vector<int>& cost, std::vector<int>& time) {
        int n = cost.size();
        std::vector<long long> dp(n + 1, 1e18);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            int current_cost = cost[i];
            int walls_gained = 1 + time[i];

            for (int j = n; j >= 0; --j) {
                dp[j] = std::min(dp[j], dp[std::max(0, j - walls_gained)] + current_cost);
            }
        }

        return static_cast<int>(dp[n]);
    }
};