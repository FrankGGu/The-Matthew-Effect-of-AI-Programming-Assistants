#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long minCost(int n, std::vector<int>& cuts) {
        cuts.push_back(0);
        cuts.push_back(n);
        std::sort(cuts.begin(), cuts.end());

        int m = cuts.size();
        std::vector<std::vector<long long>> dp(m, std::vector<long long>(m, 0));

        for (int len = 2; len < m; ++len) {
            for (int i = 0; i < m - len; ++i) {
                int j = i + len;
                dp[i][j] = LLONG_MAX;

                for (int k = i + 1; k < j; ++k) {
                    dp[i][j] = std::min(dp[i][j], dp[i][k] + dp[k][j]);
                }
                dp[i][j] += (long long)(cuts[j] - cuts[i]);
            }
        }
        return dp[0][m - 1];
    }
};