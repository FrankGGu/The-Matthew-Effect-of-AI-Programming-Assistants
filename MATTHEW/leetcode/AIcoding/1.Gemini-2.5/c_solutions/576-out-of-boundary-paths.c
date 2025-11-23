#define MOD 1000000007

int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
    long long dp[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    dp[startRow][startColumn] = 1;

    long long totalPaths = 0;

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    for (int move = 0; move < maxMove; move++) {
        long long next_dp[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                next_dp[i][j] = 0;
            }
        }

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (dp[r][c] == 0) {
                    continue;
                }

                for (int i = 0; i < 4; i++) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];

                    if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                        totalPaths = (totalPaths + dp[r][c]) % MOD;
                    } else {
                        next_dp[nr][nc] = (next_dp[nr][nc] + dp[r][c]) % MOD;
                    }
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = next_dp[i][j];
            }
        }
    }

    return (int)totalPaths;
}