#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, -1));

        function<int(int, int)> dfs = [&](int i, int j) {
            if (dp[i][j] != -1) return dp[i][j];
            int maxMove = 0;
            int directions[4][2] = {{-1, 1}, {0, 1}, {1, 1}};
            for (auto& dir : directions) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > grid[i][j]) {
                    maxMove = max(maxMove, 1 + dfs(ni, nj));
                }
            }
            dp[i][j] = maxMove;
            return maxMove;
        };

        int result = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                result = max(result, dfs(i, j));
            }
        }
        return result;
    }
};