#include <vector>

class Solution {
public:
    int countPaths(std::vector<std::vector<int>>& grid) {
        m = grid.size();
        n = grid[0].size();
        dp.assign(m, std::vector<int>(n, 0));

        long long total_paths = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                total_paths = (total_paths + dfs(i, j, grid)) % MOD;
            }
        }
        return total_paths;
    }

private:
    int m, n;
    const int MOD = 1e9 + 7;
    std::vector<std::vector<int>> dp;
    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    int dfs(int r, int c, std::vector<std::vector<int>>& grid) {
        if (dp[r][c] != 0) {
            return dp[r][c];
        }

        long long count = 1;

        for (auto& dir : dirs) {
            int nr = r + dir[0];
            int nc = c + dir[1];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] > grid[r][c]) {
                count = (count + dfs(nr, nc, grid)) % MOD;
            }
        }

        return dp[r][c] = count;
    }
};