#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int calculateMinimumHP(std::vector<std::vector<int>>& dungeon) {
        int m = dungeon.size();
        int n = dungeon[0].size();

        std::vector<std::vector<int>> dp(m + 1, std::vector<int>(n + 1, INT_MAX));
        dp[m][n - 1] = 1;
        dp[m - 1][n] = 1;

        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                int need = std::min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j];
                dp[i][j] = std::max(1, need);
            }
        }

        return dp[0][0];
    }
};