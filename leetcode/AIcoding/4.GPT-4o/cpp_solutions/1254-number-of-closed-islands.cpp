class Solution {
public:
    int closedIsland(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int count = 0;

        function<void(int, int)> dfs = [&](int x, int y) {
            if (x < 0 || x >= m || y < 0 || y >= n) return;
            if (grid[x][y] == 1) return;
            grid[x][y] = 1;
            dfs(x + 1, y);
            dfs(x - 1, y);
            dfs(x, y + 1);
            dfs(x, y - 1);
        };

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    int temp = count;
                    dfs(i, j);
                    if (temp == count) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};