class Solution {
public:
    int minimumTime(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> time(m, vector<int>(n, INT_MAX));
        time[0][0] = 0;
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.push({0, 0, 0});

        while (!pq.empty()) {
            auto [t, x, y] = pq.top();
            pq.pop();
            if (x == m - 1 && y == n - 1) return t;
            for (auto [dx, dy] : vector<pair<int, int>>{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}) {
                int nx = x + dx, ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int wait = (grid[nx][ny] - (t % grid[nx][ny])) % grid[nx][ny];
                    int nt = t + wait + 1;
                    if (nt < time[nx][ny]) {
                        time[nx][ny] = nt;
                        pq.push({nt, nx, ny});
                    }
                }
            }
        }
        return -1;
    }
};