#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minCost(int n, std::vector<int>& cuts) {
        std::vector<int> all_cuts;
        all_cuts.push_back(0);
        for (int cut : cuts) {
            all_cuts.push_back(cut);
        }
        all_cuts.push_back(n);

        std::sort(all_cuts.begin(), all_cuts.end());

        int m = all_cuts.size();
        std::vector<std::vector<int>> dp(m, std::vector<int>(m, 0));

        for (int len = 2; len < m; ++len) {
            for (int i = 0; i < m - len; ++i) {
                int j = i + len;
                dp[i][j] = INT_MAX; 

                for (int k = i + 1; k < j; ++k) {
                    int cost_of_current_cut = all_cuts[j] - all_cuts[i];
                    dp[i][j] = std::min(dp[i][j], cost_of_current_cut + dp[i][k] + dp[k][j]);
                }
            }
        }

        return dp[0][m - 1];
    }
};