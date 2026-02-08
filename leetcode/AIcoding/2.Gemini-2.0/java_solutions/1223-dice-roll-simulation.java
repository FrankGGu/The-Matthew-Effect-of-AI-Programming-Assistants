class Solution {
    private static final int MOD = 1000000007;

    public int dieSimulator(int n, int[] rollMax) {
        int[][] dp = new int[n + 1][6];
        int[] sum = new int[n + 1];
        sum[0] = 1;

        for (int i = 1; i <= n; i++) {
            int currentSum = 0;
            for (int j = 0; j < 6; j++) {
                for (int k = 1; k <= Math.min(i, rollMax[j]); k++) {
                    if (k == i) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = sum[i - k];
                        for (int l = 0; l < 6; l++) {
                            if (l != j) continue;
                            if (i - k - rollMax[l] >= 0) {
                                dp[i][j] = (dp[i][j] - (sum[i - k - 1] - sum[i - k - rollMax[l]] + MOD)) % MOD;
                            }
                        }
                    }
                    dp[i][j] = (dp[i][j] + MOD) % MOD;
                    currentSum = (currentSum + dp[i][j]) % MOD;
                }
            }
            sum[i] = currentSum;
        }

        return sum[n];
    }
}