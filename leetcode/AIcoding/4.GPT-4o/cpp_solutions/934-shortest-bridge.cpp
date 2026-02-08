class Solution {
public:
    int shortestBridge(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        vector<vector<int>> directions{{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
        queue<pair<int, int>> q;

        function<void(int, int)> dfs = [&](int x, int y) {
            grid[x][y] = 2;
            q.push({x, y});
            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] == 1) {
                    dfs(nx, ny);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1) {
                    dfs(i, j);
                    goto found;
                }
            }
        }

    found:
        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front(); q.pop();
                for (auto& dir : directions) {
                    int nx = x + dir[0], ny = y + dir[1];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                        if (grid[nx][ny] == 1) return steps;
                        if (grid[nx][ny] == 0) {
                            grid[nx][ny] = 2;
                            q.push({nx, ny});
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
};