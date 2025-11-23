class Solution {
    public int maximumProduct(int[] nums, int k) {
        int n = nums.length;
        int MOD = 1_000_000_007;
        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            int num = nums[i - 1];
            for (int j = 0; j <= k; j++) {
                if (dp[i - 1][j] != -1) {
                    // Not take the current number
                    if (dp[i][j] < dp[i - 1][j]) {
                        dp[i][j] = dp[i - 1][j];
                    }
                    // Take the current number with positive sign
                    int newJ = j + num;
                    if (newJ <= k) {
                        if (dp[i][newJ] < (dp[i - 1][j] * num) % MOD) {
                            dp[i][newJ] = (dp[i - 1][j] * num) % MOD;
                        }
                    }
                    // Take the current number with negative sign
                    newJ = j - num;
                    if (newJ >= 0) {
                        if (dp[i][newJ] < (dp[i - 1][j] * num) % MOD) {
                            dp[i][newJ] = (dp[i - 1][j] * num) % MOD;
                        }
                    }
                }
            }
        }
        return (int) (dp[n][k] % MOD);
    }
}