class Solution {
public:
    int maximumSafenessFactor(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] == 1 || grid[n-1][n-1] == 1) return 0;

        queue<pair<int, int>> q;
        vector<vector<int>> dist(n, vector<int>(n, INT_MAX));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] > dist[x][y] + 1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        priority_queue<pair<int, pair<int, int>>> pq;
        pq.push({dist[0][0], {0, 0}});
        vector<vector<int>> max_sf(n, vector<int>(n, -1));
        max_sf[0][0] = dist[0][0];

        while (!pq.empty()) {
            auto [sf, pos] = pq.top();
            auto [x, y] = pos;
            pq.pop();

            if (x == n-1 && y == n-1) return sf;
            if (sf < max_sf[x][y]) continue;

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < n) {
                    int new_sf = min(sf, dist[nx][ny]);
                    if (new_sf > max_sf[nx][ny]) {
                        max_sf[nx][ny] = new_sf;
                        pq.push({new_sf, {nx, ny}});
                    }
                }
            }
        }

        return 0;
    }
};