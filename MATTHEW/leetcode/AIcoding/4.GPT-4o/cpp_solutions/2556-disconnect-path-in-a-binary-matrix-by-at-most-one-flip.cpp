class Solution {
public:
    bool canDisconnect(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        if (grid[0][0] == 1 && grid[m-1][n-1] == 1) return false;

        vector<vector<int>> directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
        queue<pair<int, int>> q;
        vector<vector<int>> visited(m, vector<int>(n, 0));
        q.push({0, 0});
        visited[0][0] = 1;

        while (!q.empty()) {
            auto [x, y] = q.front(); q.pop();
            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny] && grid[nx][ny] == 0) {
                    visited[nx][ny] = 1;
                    q.push({nx, ny});
                }
            }
        }

        if (visited[m-1][n-1]) return true;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    fill(visited.begin(), visited.end(), vector<int>(n, 0));
                    q.push({0, 0});
                    visited[0][0] = 1;

                    while (!q.empty()) {
                        auto [x, y] = q.front(); q.pop();
                        for (auto& dir : directions) {
                            int nx = x + dir[0], ny = y + dir[1];
                            if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny] && grid[nx][ny] == 0) {
                                visited[nx][ny] = 1;
                                q.push({nx, ny});
                            }
                        }
                    }

                    if (visited[m-1][n-1]) return true;
                    grid[i][j] = 1;
                }
            }
        }

        return false;
    }
};