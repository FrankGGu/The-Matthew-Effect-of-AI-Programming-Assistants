#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxValue(vector<vector<int>>& grid) {
        if (grid.empty() || grid[0].empty()) return 0;
        int m = grid.size();
        int n = grid[0].size();
        vector<int> dp(n, 0);
        dp[0] = grid[0][0];
        for (int j = 1; j < n; ++j) {
            dp[j] = dp[j-1] + grid[0][j];
        }
        for (int i = 1; i < m; ++i) {
            dp[0] += grid[i][0];
            for (int j = 1; j < n; ++j) {
                dp[j] = max(dp[j-1], dp[j]) + grid[i][j];
            }
        }
        return dp[n-1];
    }
};