#include <vector>
#include <algorithm>

using namespace std;

int maximizeTheProfit(int n, vector<vector<int>>& offers) {
    vector<vector<int>> dp(n + 1, vector<int>(2, 0));

    sort(offers.begin(), offers.end(), [](const vector<int>& a, const vector<int>& b) {
        return a[1] < b[1];
    });

    for (int i = 1; i <= n; ++i) {
        dp[i][0] = dp[i - 1][0];

        for (const auto& offer : offers) {
            if (offer[1] == i - 1) {
                int start = offer[0];
                int gold = offer[2];

                int prevProfit = (start == 0) ? 0 : dp[start][0];
                dp[i][0] = max(dp[i][0], prevProfit + gold);
            }
        }
        dp[i][0] = max(dp[i][0], dp[i-1][0]);
    }

    return dp[n][0];
}