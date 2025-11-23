double knightProbability(int n, int k, int row, int column) {
    if (k == 0) return 1.0;

    double dp[25][25][101] = {0};
    int moves[8][2] = {{-2,-1},{-2,1},{-1,-2},{-1,2},{1,-2},{1,2},{2,-1},{2,1}};

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j][0] = 1.0;
        }
    }

    for (int step = 1; step <= k; step++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                double prob = 0.0;
                for (int m = 0; m < 8; m++) {
                    int ni = i + moves[m][0];
                    int nj = j + moves[m][1];
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        prob += dp[ni][nj][step-1] / 8.0;
                    }
                }
                dp[i][j][step] = prob;
            }
        }
    }

    return dp[row][column][k];
}