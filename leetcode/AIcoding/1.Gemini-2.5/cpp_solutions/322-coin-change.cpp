#include <vector>
#include <algorithm>

class Solution {
public:
    int coinChange(std::vector<int>& coins, int amount) {
        if (amount < 0) {
            return -1;
        }
        if (amount == 0) {
            return 0;
        }

        std::vector<int> dp(amount + 1, amount + 1);
        dp[0] = 0;

        for (int i = 1; i <= amount; ++i) {
            for (int coin : coins) {
                if (i - coin >= 0) {
                    if (dp[i - coin] != amount + 1) { // Check if subproblem is solvable
                        dp[i] = std::min(dp[i], 1 + dp[i - coin]);
                    }
                }
            }
        }

        return (dp[amount] == amount + 1) ? -1 : dp[amount];
    }
};