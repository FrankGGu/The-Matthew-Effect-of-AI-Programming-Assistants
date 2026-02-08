class Solution {
public:
    int countInfectionSequences(vector<string>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        int count = 0;

        function<void(int, int)> dfs = [&](int x, int y) {
            grid[x][y] = '0'; // Mark as visited
            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == '1') {
                    dfs(nx, ny);
                }
            }
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '1') {
                    dfs(i, j);
                    count++;
                }
            }
        }

        return count;
    }
};