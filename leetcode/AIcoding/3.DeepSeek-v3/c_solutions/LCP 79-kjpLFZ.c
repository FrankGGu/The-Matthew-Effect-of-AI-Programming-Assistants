int incantation(char* matrix, int matrixSize, char* incantation) {
    int n = matrixSize;
    int len = strlen(incantation);
    if (len == 0) return 0;

    int dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = (matrix[i * n + j] == incantation[0]) ? 1 : -1;
        }
    }

    for (int k = 1; k < len; k++) {
        int next[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                next[i][j] = -1;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dp[i][j] != -1) {
                    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};
                    for (int d = 0; d < 4; d++) {
                        int ni = i + dirs[d][0];
                        int nj = j + dirs[d][1];
                        if (ni >= 0 && ni < n && nj >= 0 && nj < n && matrix[ni * n + nj] == incantation[k]) {
                            if (next[ni][nj] == -1 || dp[i][j] + 1 < next[ni][nj]) {
                                next[ni][nj] = dp[i][j] + 1;
                            }
                        }
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = next[i][j];
            }
        }
    }

    int res = -1;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (dp[i][j] != -1) {
                if (res == -1 || dp[i][j] < res) {
                    res = dp[i][j];
                }
            }
        }
    }
    return res;
}