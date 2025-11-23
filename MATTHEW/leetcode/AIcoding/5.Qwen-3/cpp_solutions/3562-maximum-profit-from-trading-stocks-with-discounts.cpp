#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int n = prices.size();
        vector<int> dp(n, 0);
        for (int i = 1; i < n; ++i) {
            dp[i] = max(dp[i - 1], prices[i] - prices[0] + dp[0]);
            for (int j = 1; j < i; ++j) {
                dp[i] = max(dp[i], prices[i] - prices[j] + dp[j - 1]);
            }
        }
        return dp[n - 1];
    }
};