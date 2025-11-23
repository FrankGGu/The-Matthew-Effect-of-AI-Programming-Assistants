#include <vector>
#include <numeric>

class Solution {
public:
    int change(int amount, std::vector<int>& coins) {
        std::vector<int> dp(amount + 1, 0);
        dp[0] = 1;

        for (int coin : coins) {
            for (int j = coin; j <= amount; ++j) {
                dp[j] += dp[j - coin];
            }
        }

        return dp[amount];
    }
};