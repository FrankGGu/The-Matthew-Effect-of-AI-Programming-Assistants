#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& offers) {
        vector<vector<int>> dp(n + 1, vector<int>(2, 0));
        vector<vector<int>> houses(n);
        for (auto& offer : offers) {
            houses[offer[1]].push_back(offer[0] * 1000 + offer[2]);
        }

        for (int i = 0; i < n; ++i) {
            dp[i + 1][0] = max(dp[i][0], dp[i][1]);
            dp[i + 1][1] = dp[i + 1][0];
            for (int offer : houses[i]) {
                int start = offer / 1000;
                int profit = offer % 1000;
                dp[i + 1][1] = max(dp[i + 1][1], max(dp[start][0], dp[start][1]) + profit);
            }
        }

        return max(dp[n][0], dp[n][1]);
    }
};