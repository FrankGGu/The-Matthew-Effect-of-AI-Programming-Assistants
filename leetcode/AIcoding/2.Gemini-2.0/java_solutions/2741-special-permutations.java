class Solution {
    private static final int MOD = 1000000007;

    public int specialPerm(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[1 << n][n];
        for (int i = 0; i < n; i++) {
            dp[1 << i][i] = 1;
        }

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = 0; j < n; j++) {
                        if (i != j && (mask & (1 << j)) != 0 && (nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0)) {
                            dp[mask][i] = (dp[mask][i] + dp[mask ^ (1 << i)][j]) % MOD;
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < n; i++) {
            ans = (ans + dp[(1 << n) - 1][i]) % MOD;
        }

        return ans;
    }
}