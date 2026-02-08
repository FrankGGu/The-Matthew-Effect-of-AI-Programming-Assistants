public class Solution {
    public int findPaths(int m, int n, int N, int x, int y) {
        int[][][] dp = new int[m][n][N + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j][0] = 0;
            }
        }
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                    dp[i][j][1] = 1;
                } else {
                    dp[i][j][1] = 0;
                }
            }
        }
        for (int step = 2; step <= N; step++) {
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    int count = 0;
                    if (i - 1 < 0) count++;
                    else count += dp[i - 1][j][step - 1];
                    if (i + 1 >= m) count++;
                    else count += dp[i + 1][j][step - 1];
                    if (j - 1 < 0) count++;
                    else count += dp[i][j - 1][step - 1];
                    if (j + 1 >= n) count++;
                    else count += dp[i][j + 1][step - 1];
                    dp[i][j][step] = count;
                }
            }
        }
        return dp[x][y][N];
    }
}