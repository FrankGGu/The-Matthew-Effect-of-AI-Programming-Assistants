import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int maxProduct(int[] nums, int k) {
        int n = nums.length;
        long[][][] dp = new long[n + 1][2][k + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j < 2; j++) {
                Arrays.fill(dp[i][j], -1);
            }
        }

        dp[0][0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < 2; j++) {
                for (int l = 0; l <= k; l++) {
                    dp[i][j][l] = dp[i - 1][j][l];
                    if (dp[i][j][l] == -1) continue;

                    if (j == 0) {
                        if (l + nums[i - 1] <= k) {
                            if (dp[i - 1][1][l + nums[i - 1]] != -1) {
                                dp[i][j][l] = Math.max(dp[i][j][l], (dp[i - 1][1][l + nums[i - 1]] * nums[i - 1]) % MOD);
                            }
                        }
                    } else {
                        if (l - nums[i - 1] >= 0) {
                            if (dp[i - 1][0][l - nums[i - 1]] != -1) {
                                dp[i][j][l] = Math.max(dp[i][j][l], (dp[i - 1][0][l - nums[i - 1]] * nums[i - 1]) % MOD);
                            }
                        }
                    }
                }
            }
            for (int j = 0; j < 2; j++) {
                for (int l = 0; l <= k; l++) {
                    if (dp[i-1][j][l] != -1) {
                      dp[i][j][l] = Math.max(dp[i][j][l], dp[i-1][j][l]);
                    }
                }
            }
            if (j == 0) {
                if (k + nums[i - 1] <= k) {
                   if (dp[i - 1][1][k + nums[i - 1]] != -1) {
                       dp[i][0][k] = Math.max(dp[i][0][k], (dp[i - 1][1][k + nums[i - 1]] * nums[i - 1]) % MOD);
                   }
                }
            } else {
                if (k - nums[i - 1] >= 0) {
                    if (dp[i - 1][0][k - nums[i - 1]] != -1) {
                        dp[i][1][k] = Math.max(dp[i][1][k], (dp[i - 1][0][k - nums[i - 1]] * nums[i - 1]) % MOD);
                    }
                }
            }
        }

        return (int) Math.max(dp[n][0][k], dp[n][1][k]);
    }
}