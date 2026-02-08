#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string largestNumber(std::vector<int>& cost, int target) {
        std::vector<std::string> dp(target + 1, "");
        dp[0] = "";

        for (int i = 1; i <= target; ++i) {
            for (int j = 0; j < 9; ++j) {
                if (i >= cost[j] && !dp[i - cost[j]].empty() || i == cost[j]) {
                    std::string candidate = dp[i - cost[j]] + std::to_string(j + 1);
                    if (candidate.length() > dp[i].length() || (candidate.length() == dp[i].length() && candidate > dp[i])) {
                        dp[i] = candidate;
                    }
                }
            }
        }

        return dp[target].empty() ? "0" : dp[target];
    }
};