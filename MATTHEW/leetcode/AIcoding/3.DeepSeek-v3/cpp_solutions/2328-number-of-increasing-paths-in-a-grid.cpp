class Solution {
public:
    int countPaths(vector<vector<int>>& grid) {
        const int MOD = 1e9 + 7;
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<long long>> dp(m, vector<long long>(n, 1));
        vector<pair<int, pair<int, int>>> cells;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                cells.push_back({grid[i][j], {i, j}});
            }
        }

        sort(cells.begin(), cells.end());

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (auto& cell : cells) {
            int i = cell.second.first;
            int j = cell.second.second;
            for (auto& dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > grid[i][j]) {
                    dp[ni][nj] = (dp[ni][nj] + dp[i][j]) % MOD;
                }
            }
        }

        long long res = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                res = (res + dp[i][j]) % MOD;
            }
        }

        return res;
    }
};