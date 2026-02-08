class Solution {
public:
    int numEnclaves(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        function<void(int, int)> dfs = [&](int x, int y) {
            if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == 0) return;
            grid[x][y] = 0;
            for (auto& dir : directions) {
                dfs(x + dir[0], y + dir[1]);
            }
        };

        for (int i = 0; i < m; ++i) {
            dfs(i, 0);
            dfs(i, n - 1);
        }

        for (int j = 0; j < n; ++j) {
            dfs(0, j);
            dfs(m - 1, j);
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                count += grid[i][j];
            }
        }

        return count;
    }
};