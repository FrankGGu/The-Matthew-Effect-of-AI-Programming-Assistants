class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, INT_MIN)));
        dp[0][0][0] = grid[0][0];

        for (int x1 = 0; x1 < n; x1++) {
            for (int x2 = 0; x2 < n; x2++) {
                for (int k = 0; k <= x1; k++) {
                    int y1 = x1 - k;
                    int y2 = x2 - k;
                    if (y1 < 0 || y2 < 0 || y1 >= n || y2 >= n) continue;
                    if (grid[y1][x1] == -1 || grid[y2][x2] == -1) continue;

                    int cherries = grid[y1][x1];
                    if (x1 != x2) cherries += grid[y2][x2];
                    for (int dx1 = -1; dx1 <= 0; dx1++) {
                        for (int dx2 = -1; dx2 <= 0; dx2++) {
                            int nx1 = x1 + dx1;
                            int nx2 = x2 + dx2;
                            if (nx1 >= 0 && nx2 >= 0) {
                                dp[y1][x1][x2] = max(dp[y1][x1][x2], dp[nx1][x1][nx2] + cherries);
                            }
                        }
                    }
                }
            }
        }
        return max(0, dp[n-1][n-1][n-1]);
    }
};