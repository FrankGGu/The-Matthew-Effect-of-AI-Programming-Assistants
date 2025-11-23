class Solution {
public:
    int maxDistance(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> dist(n, vector<int>(n, -1));
        queue<pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        int maxDist = -1;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();
                for (auto& d : directions) {
                    int nx = x + d[0], ny = y + d[1];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] == -1) {
                        dist[nx][ny] = dist[x][y] + 1;
                        maxDist = max(maxDist, dist[nx][ny]);
                        q.push({nx, ny});
                    }
                }
            }
        }

        return maxDist;
    }
};