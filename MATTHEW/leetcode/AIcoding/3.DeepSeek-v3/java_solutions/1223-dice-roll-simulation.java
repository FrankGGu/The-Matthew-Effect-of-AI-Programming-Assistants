class Solution {
    private static final int MOD = 1000000007;

    public int dieSimulator(int n, int[] rollMax) {
        int[][][] dp = new int[n + 1][7][16];
        for (int j = 1; j <= 6; j++) {
            dp[1][j][1] = 1;
        }
        for (int i = 1; i < n; i++) {
            for (int j = 1; j <= 6; j++) {
                for (int k = 1; k <= rollMax[j - 1]; k++) {
                    if (dp[i][j][k] == 0) continue;
                    for (int nj = 1; nj <= 6; nj++) {
                        if (nj == j) {
                            if (k + 1 <= rollMax[j - 1]) {
                                dp[i + 1][nj][k + 1] = (dp[i + 1][nj][k + 1] + dp[i][j][k]) % MOD;
                            }
                        } else {
                            dp[i + 1][nj][1] = (dp[i + 1][nj][1] + dp[i][j][k]) % MOD;
                        }
                    }
                }
            }
        }
        int res = 0;
        for (int j = 1; j <= 6; j++) {
            for (int k = 1; k <= rollMax[j - 1]; k++) {
                res = (res + dp[n][j][k]) % MOD;
            }
        }
        return res;
    }
}