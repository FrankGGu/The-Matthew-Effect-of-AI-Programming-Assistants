#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTotalValue(vector<vector<int>>& bags, int k) {
        int n = bags.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                for (int x = 0; x < bags[i - 1].size() / 2 && x < j; ++x) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - x - 1] + bags[i - 1][2 * x] * 1LL * bags[i - 1][2 * x + 1]);
                }
                if (j > 0 && bags[i-1].size() > 0) {
                    dp[i][j] = max(dp[i][j], dp[i-1][j-1] + (bags[i-1].size() > 0 ? bags[i-1][0] * 1LL * bags[i-1][1] : 0));
                }
            }
        }

        return dp[n][k];
    }
};