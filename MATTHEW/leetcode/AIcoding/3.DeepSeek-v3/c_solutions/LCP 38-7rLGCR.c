int guardCastle(char** grid, int gridSize) {
    int n = gridSize;
    int m = strlen(grid[0]);

    int INF = 1000000000;
    int ans = INF;

    for (int t = 0; t < 2; t++) {
        int dp[2][2];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                dp[i][j] = INF;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int new_dp[2][2];
                for (int x = 0; x < 2; x++) {
                    for (int y = 0; y < 2; y++) {
                        new_dp[x][y] = INF;
                    }
                }

                for (int a = 0; a < 2; a++) {
                    for (int b = 0; b < 2; b++) {
                        if (dp[a][b] == INF) continue;

                        for (int c = 0; c < 2; c++) {
                            for (int d = 0; d < 2; d++) {
                                if (i == 0 && c != t) continue;
                                if (j == 0 && d != 0) continue;

                                int cost = 0;
                                if (grid[i][j] == 'S') {
                                    if (c == 0) cost = INF;
                                } else if (grid[i][j] == 'P') {
                                    if (c == 1) cost = INF;
                                }

                                if (cost == INF) continue;

                                if (c == 1 && d == 1) cost++;

                                if (i > 0 && c != a) cost++;
                                if (j > 0 && d != b) cost++;

                                if (new_dp[c][d] > dp[a][b] + cost) {
                                    new_dp[c][d] = dp[a][b] + cost;
                                }
                            }
                        }
                    }
                }

                for (int x = 0; x < 2; x++) {
                    for (int y = 0; y < 2; y++) {
                        dp[x][y] = new_dp[x][y];
                    }
                }
            }
        }

        for (int a = 0; a < 2; a++) {
            for (int b = 0; b < 2; b++) {
                if (ans > dp[a][b]) {
                    ans = dp[a][b];
                }
            }
        }
    }

    return ans == INF ? -1 : ans;
}