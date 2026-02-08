#include <vector>

using namespace std;

class Solution {
public:
    int countPaths(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int ans = 0;
        int mod = 1e9 + 7;

        function<int(int, int)> dfs = [&](int i, int j) {
            if (dp[i][j] != 0) {
                return dp[i][j];
            }

            dp[i][j] = 1;
            int dx[] = {0, 0, 1, -1};
            int dy[] = {1, -1, 0, 0};

            for (int k = 0; k < 4; ++k) {
                int ni = i + dx[k];
                int nj = j + dy[k];

                if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > grid[i][j]) {
                    dp[i][j] = (dp[i][j] + dfs(ni, nj)) % mod;
                }
            }
            return dp[i][j];
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                ans = (ans + dfs(i, j)) % mod;
            }
        }

        return ans;
    }
};