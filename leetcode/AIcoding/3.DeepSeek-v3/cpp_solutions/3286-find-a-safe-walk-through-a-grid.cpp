class Solution {
public:
    vector<vector<int>> findSafePath(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return {};
        int n = grid[0].size();
        if (n == 0) return {};

        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    dist[i][j] = 0;
                    q.push({i, j});
                }
            }
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!q.empty()) {
            auto curr = q.front();
            q.pop();
            int x = curr.first;
            int y = curr.second;
            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    if (dist[nx][ny] > dist[x][y] + 1) {
                        dist[nx][ny] = dist[x][y] + 1;
                        q.push({nx, ny});
                    }
                }
            }
        }

        priority_queue<tuple<int, int, int>> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        if (dist[0][0] == 0) return {};
        pq.push({dist[0][0], 0, 0});
        visited[0][0] = true;

        vector<vector<int>> path;
        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int d = get<0>(curr);
            int x = get<1>(curr);
            int y = get<2>(curr);
            path.push_back({x, y});
            if (x == m - 1 && y == n - 1) {
                return path;
            }
            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && dist[nx][ny] > 0) {
                    visited[nx][ny] = true;
                    pq.push({dist[nx][ny], nx, ny});
                }
            }
        }

        return {};
    }
};