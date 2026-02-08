class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < m; i++) {
            vector<vector<int>> new_dp(n, vector<int>(n, 0));
            for (int j1 = 0; j1 < n; j1++) {
                for (int j2 = 0; j2 < n; j2++) {
                    if (grid[i][j1] == -1 || grid[i][j2] == -1) continue;
                    int cherries = (j1 == j2) ? grid[i][j1] : grid[i][j1] + grid[i][j2];
                    for (int dj1 = -1; dj1 <= 1; dj1++) {
                        for (int dj2 = -1; dj2 <= 1; dj2++) {
                            int nj1 = j1 + dj1, nj2 = j2 + dj2;
                            if (nj1 >= 0 && nj1 < n && nj2 >= 0 && nj2 < n) {
                                new_dp[nj1][nj2] = max(new_dp[nj1][nj2], dp[j1][j2] + cherries);
                            }
                        }
                    }
                }
            }
            dp = new_dp;
        }

        int result = 0;
        for (int j1 = 0; j1 < n; j1++) {
            for (int j2 = 0; j2 < n; j2++) {
                result = max(result, dp[j1][j2]);
            }
        }
        return result;
    }
};