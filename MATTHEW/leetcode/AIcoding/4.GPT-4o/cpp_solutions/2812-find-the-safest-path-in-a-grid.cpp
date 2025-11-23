class Solution {
public:
    int maximumSafenessFactor(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        vector<vector<int>> safeness(n, vector<int>(m, 0));
        vector<vector<int>> directions{{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        queue<pair<int, int>> q;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 1) {
                    safeness[i][j] = -1;
                    q.push({i, j});
                }
            }
        }

        int level = 0;
        while (!q.empty()) {
            int size = q.size();
            while (size--) {
                auto [x, y] = q.front(); q.pop();
                for (auto& d : directions) {
                    int nx = x + d[0], ny = y + d[1];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < m && safeness[nx][ny] == 0) {
                        safeness[nx][ny] = level + 1;
                        q.push({nx, ny});
                    }
                }
            }
            level++;
        }

        int maxSafeness = 0;
        vector<vector<int>> dp(n, vector<int>(m, INT_MIN));
        dp[0][0] = safeness[0][0];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (i > 0) dp[i][j] = max(dp[i][j], min(dp[i-1][j], safeness[i][j]));
                if (j > 0) dp[i][j] = max(dp[i][j], min(dp[i][j-1], safeness[i][j]));
            }
        }
        return dp[n-1][m-1];
    }
};