class Solution {
public:
    int countUnguarded(int m, int n, vector<vector<int>>& guards, vector<vector<int>>& walls) {
        vector<vector<int>> grid(m, vector<int>(n, 0));

        for (auto& g : guards) {
            grid[g[0]][g[1]] = 1;
        }

        for (auto& w : walls) {
            grid[w[0]][w[1]] = 2;
        }

        for (auto& g : guards) {
            int x = g[0], y = g[1];
            for (int i = x; i >= 0 && grid[i][y] != 2; --i) grid[i][y] = 3;
            for (int i = x; i < m && grid[i][y] != 2; ++i) grid[i][y] = 3;
            for (int j = y; j >= 0 && grid[x][j] != 2; --j) grid[x][j] = 3;
            for (int j = y; j < n && grid[x][j] != 2; ++j) grid[x][j] = 3;
        }

        int count = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) ++count;
            }
        }

        return count;
    }
};