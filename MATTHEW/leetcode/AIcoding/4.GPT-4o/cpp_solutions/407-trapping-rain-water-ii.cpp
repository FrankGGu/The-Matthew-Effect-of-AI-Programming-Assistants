class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;
        int m = heightMap.size(), n = heightMap[0].size();
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        vector<vector<int>> visited(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            pq.push({heightMap[i][0], {i, 0}});
            pq.push({heightMap[i][n - 1], {i, n - 1}});
            visited[i][0] = visited[i][n - 1] = 1;
        }
        for (int j = 0; j < n; ++j) {
            pq.push({heightMap[0][j], {0, j}});
            pq.push({heightMap[m - 1][j], {m - 1, j}});
            visited[0][j] = visited[m - 1][j] = 1;
        }

        int waterTrapped = 0, directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        while (!pq.empty()) {
            auto [height, pos] = pq.top();
            pq.pop();
            int x = pos.first, y = pos.second;

            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny]) {
                    waterTrapped += max(0, height - heightMap[nx][ny]);
                    pq.push({max(height, heightMap[nx][ny]), {nx, ny}});
                    visited[nx][ny] = 1;
                }
            }
        }

        return waterTrapped;
    }
};