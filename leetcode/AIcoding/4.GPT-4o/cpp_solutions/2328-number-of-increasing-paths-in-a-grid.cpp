class Solution {
public:
    int MOD = 1e9 + 7;
    vector<vector<int>> dp;
    vector<vector<int>> directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    int dfs(int x, int y, vector<vector<int>>& grid) {
        if (dp[x][y] != -1) return dp[x][y];
        long long count = 1;

        for (auto& dir : directions) {
            int nx = x + dir[0], ny = y + dir[1];
            if (nx >= 0 && nx < grid.size() && ny >= 0 && ny < grid[0].size() && grid[nx][ny] > grid[x][y]) {
                count = (count + dfs(nx, ny, grid)) % MOD;
            }
        }

        return dp[x][y] = count;
    }

    int countPaths(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        dp.resize(m, vector<int>(n, -1));
        long long totalPaths = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                totalPaths = (totalPaths + dfs(i, j, grid)) % MOD;
            }
        }

        return totalPaths;
    }
};