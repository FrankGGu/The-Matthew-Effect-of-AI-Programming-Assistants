class Solution {
public:
    int minimumTime(vector<vector<int>>& grid) {
        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }

        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> pq;
        pq.emplace(0, 0, 0);
        dist[0][0] = 0;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.empty()) {
            auto [time, x, y] = pq.top();
            pq.pop();

            if (x == m - 1 && y == n - 1) {
                return time;
            }

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx < 0 || nx >= m || ny < 0 || ny >= n) {
                    continue;
                }

                int requiredTime = grid[nx][ny];
                int newTime = time + 1;
                if (newTime < requiredTime) {
                    int diff = requiredTime - newTime;
                    if (diff % 2 == 0) {
                        newTime = requiredTime;
                    } else {
                        newTime = requiredTime + 1;
                    }
                }

                if (newTime < dist[nx][ny]) {
                    dist[nx][ny] = newTime;
                    pq.emplace(newTime, nx, ny);
                }
            }
        }

        return -1;
    }
};