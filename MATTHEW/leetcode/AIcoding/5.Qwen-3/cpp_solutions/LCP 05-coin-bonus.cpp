#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int coinBonus(std::vector<int>& coins) {
        int n = coins.size();
        if (n == 0) return 0;
        std::vector<int> dp(n, 0);
        dp[0] = coins[0];
        if (n == 1) return dp[0];
        dp[1] = std::max(coins[0], coins[1]);
        for (int i = 2; i < n; ++i) {
            dp[i] = std::max(dp[i - 1], dp[i - 2] + coins[i]);
        }
        return dp[n - 1];
    }
};