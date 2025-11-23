class Solution {
public:
    vector<vector<int>> pacificAtlantic(vector<vector<int>>& heights) {
        if (heights.empty()) return {};
        int m = heights.size(), n = heights[0].size();
        vector<vector<int>> pacific(m, vector<int>(n, 0));
        vector<vector<int>> atlantic(m, vector<int>(n, 0));
        vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        auto bfs = [&](vector<vector<int>>& ocean) {
            queue<pair<int, int>> q;
            for (int i = 0; i < m; ++i) {
                q.push({i, 0});
                ocean[i][0] = 1;
                q.push({i, n - 1});
                ocean[i][n - 1] = 1;
            }
            for (int j = 0; j < n; ++j) {
                q.push({0, j});
                ocean[0][j] = 1;
                q.push({m - 1, j});
                ocean[m - 1][j] = 1;
            }
            while (!q.empty()) {
                auto [x, y] = q.front(); q.pop();
                for (auto& d : directions) {
                    int nx = x + d[0], ny = y + d[1];
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && !ocean[nx][ny] && heights[nx][ny] >= heights[x][y]) {
                        ocean[nx][ny] = 1;
                        q.push({nx, ny});
                    }
                }
            }
        };

        bfs(pacific);
        bfs(atlantic);

        vector<vector<int>> result;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.push_back({i, j});
                }
            }
        }
        return result;
    }
};