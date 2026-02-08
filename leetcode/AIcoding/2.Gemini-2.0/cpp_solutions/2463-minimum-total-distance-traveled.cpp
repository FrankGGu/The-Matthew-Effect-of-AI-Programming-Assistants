#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumTotalDistance(vector<int>& robots, vector<vector<int>>& factories) {
        int n = robots.size();
        int m = factories.size();
        sort(robots.begin(), robots.end());
        sort(factories.begin(), factories.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        vector<vector<long long>> dp(n + 1, vector<long long>(m + 1, 1e18));
        dp[0][0] = 0;

        for (int i = 0; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                dp[i][j] = dp[i][j - 1];
                long long cost = 0;
                for (int k = 1; k <= min(i, factories[j - 1][1]); ++k) {
                    cost += abs(robots[i - k] - factories[j - 1][0]);
                    dp[i][j] = min(dp[i][j], dp[i - k][j - 1] + cost);
                }
            }
        }

        return dp[n][m];
    }
};