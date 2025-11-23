#include <vector>
#include <climits>

class Solution {
public:
    int change(int amount, std::vector<int>& coins) {
        std::vector<unsigned long long> dp(amount + 1, 0);
        dp[0] = 1;
        for (int coin : coins) {
            for (int i = coin; i <= amount; ++i) {
                dp[i] += dp[i - coin];
            }
        }
        return dp[amount];
    }
};