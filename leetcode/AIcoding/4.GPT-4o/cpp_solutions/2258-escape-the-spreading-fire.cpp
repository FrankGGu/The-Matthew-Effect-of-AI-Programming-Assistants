class Solution {
public:
    int maximumMinutes(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> fire(m, vector<int>(n, INT_MAX));
        queue<pair<int, int>> q;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    fire[i][j] = 0;
                    q.push({i, j});
                }
            }
        }

        vector<vector<int>> directions = {{1,0}, {-1,0}, {0,1}, {0,-1}};

        while (!q.empty()) {
            auto [x, y] = q.front(); q.pop();
            for (auto& dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && fire[nx][ny] > fire[x][y] + 1) {
                    fire[nx][ny] = fire[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int startTime = fire[0][0];
        if (startTime == INT_MAX) return 0;
        if (startTime == 0) return 1;

        int escapeTime = startTime + 1;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && fire[i][j] < escapeTime) {
                    return 0;
                }
            }
        }

        return (escapeTime == startTime + 1) ? 1 : 2;
    }
};