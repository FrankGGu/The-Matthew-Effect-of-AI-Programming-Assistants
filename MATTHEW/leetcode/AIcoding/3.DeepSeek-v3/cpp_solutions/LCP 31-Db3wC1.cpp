class Solution {
public:
    bool escapeMaze(vector<vector<string>>& maze) {
        int T = maze.size(), n = maze[0].size(), m = maze[0][0].size();
        vector<vector<vector<vector<bool>>>> dp(T, vector<vector<vector<bool>>>(n, vector<vector<bool>>(m, vector<bool>(4, false))));
        int dirs[5] = {0, 1, 0, -1, 0};

        dp[0][0][0][0] = true;

        for (int t = 0; t < T - 1; ++t) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < m; ++j) {
                    for (int s = 0; s < 4; ++s) {
                        if (!dp[t][i][j][s]) continue;
                        for (int d = 0; d < 4; ++d) {
                            int ni = i + dirs[d], nj = j + dirs[d + 1];
                            if (ni < 0 || ni >= n || nj < 0 || nj >= m) continue;
                            for (int ns = s; ns < 4; ++ns) {
                                if (maze[t + 1][ni][nj] == '.') {
                                    dp[t + 1][ni][nj][ns] = true;
                                } else {
                                    if (ns == 0) {
                                        dp[t + 1][ni][nj][1] = true;
                                    } else if (ns == 1) {
                                        dp[t + 1][ni][nj][3] = true;
                                    } else if (ns == 2) {
                                        dp[t + 1][ni][nj][3] = true;
                                    }
                                }
                            }
                        }
                        for (int ns = s; ns < 4; ++ns) {
                            if (ns == 0) {
                                dp[t + 1][i][j][2] = true;
                            } else if (ns == 1) {
                                dp[t + 1][i][j][3] = true;
                            } else if (ns == 2) {
                                dp[t + 1][i][j][3] = true;
                            }
                        }
                    }
                }
            }
        }

        for (int t = 0; t < T; ++t) {
            for (int s = 0; s < 4; ++s) {
                if (dp[t][n - 1][m - 1][s]) {
                    return true;
                }
            }
        }
        return false;
    }
};