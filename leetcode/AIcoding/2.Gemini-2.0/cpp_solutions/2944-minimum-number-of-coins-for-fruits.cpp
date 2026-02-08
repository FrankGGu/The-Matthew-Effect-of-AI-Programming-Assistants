#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCoins(vector<int>& prices) {
        int n = prices.size();
        vector<int> dp(n + 1, 0);

        for (int i = n - 1; i >= 0; --i) {
            int buy_cost = prices[i];
            int next_day = min(n, i + prices[i] + 1);
            dp[i] = buy_cost + dp[next_day];
            if (i < n - 1) {
                dp[i] = min(dp[i], dp[i + 1]);
            }
        }
        return dp[0];
    }
};