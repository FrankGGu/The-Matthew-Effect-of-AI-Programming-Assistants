#include <vector>
#include <algorithm>
#include <limits>

using namespace std;

class Solution {
public:
    int minCost(int n, vector<int>& cuts, int cost_per_cut) {
        cuts.push_back(0);
        cuts.push_back(n);
        sort(cuts.begin(), cuts.end());
        int m = cuts.size();
        vector<vector<int>> dp(m, vector<int>(m, 0));

        for (int len = 2; len < m; ++len) {
            for (int i = 0; i < m - len; ++i) {
                int j = i + len;
                dp[i][j] = numeric_limits<int>::max();
                for (int k = i + 1; k < j; ++k) {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j] + (cuts[j] - cuts[i]) * cost_per_cut);
                }
            }
        }

        return dp[0][m - 1];
    }
};