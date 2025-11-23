class Solution {
public:
    int maximumMinutes(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> fireTime(m, vector<int>(n, INT_MAX));
        queue<pair<int, int>> fireQueue;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    fireTime[i][j] = 0;
                    fireQueue.push({i, j});
                }
            }
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!fireQueue.empty()) {
            auto [x, y] = fireQueue.front();
            fireQueue.pop();

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && fireTime[nx][ny] == INT_MAX) {
                    fireTime[nx][ny] = fireTime[x][y] + 1;
                    fireQueue.push({nx, ny});
                }
            }
        }

        int left = 0;
        int right = m * n;
        int res = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (canReach(grid, fireTime, mid)) {
                res = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return res == m * n ? 1e9 : res;
    }

    bool canReach(vector<vector<int>>& grid, vector<vector<int>>& fireTime, int wait) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<tuple<int, int, int>> q;

        if (wait <= fireTime[0][0] && grid[0][0] == 0) {
            q.push({0, 0, wait});
            visited[0][0] = true;
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y, time] = q.front();
            q.pop();

            if (x == m - 1 && y == n - 1) {
                return true;
            }

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && !visited[nx][ny]) {
                    int newTime = time + 1;
                    if (nx == m - 1 && ny == n - 1) {
                        if (newTime <= fireTime[nx][ny]) {
                            visited[nx][ny] = true;
                            q.push({nx, ny, newTime});
                        }
                    } else {
                        if (newTime < fireTime[nx][ny]) {
                            visited[nx][ny] = true;
                            q.push({nx, ny, newTime});
                        }
                    }
                }
            }
        }

        return false;
    }
};