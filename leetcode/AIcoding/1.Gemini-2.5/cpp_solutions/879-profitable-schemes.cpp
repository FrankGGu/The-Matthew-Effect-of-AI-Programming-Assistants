#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int profitableSchemes(int n, int minProfit, std::vector<int>& group, std::vector<int>& profit) {
        const int MOD = 1e9 + 7;
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(minProfit + 1, 0));
        dp[0][0] = 1;

        for (size_t i = 0; i < group.size(); ++i) {
            int g = group[i];
            int p = profit[i];
            for (int j = n; j >= g; --j) {
                for (int k = minProfit; k >= 0; --k) {
                    int new_profit = std::min(minProfit, k + p);
                    dp[j][new_profit] = (dp[j][new_profit] + dp[j - g][k]) % MOD;
                }
            }
        }

        int total_schemes = 0;
        for (int j = 0; j <= n; ++j) {
            total_schemes = (total_schemes + dp[j][minProfit]) % MOD;
        }

        return total_schemes;
    }
};