class Solution {
    private static final int MOD = 1000000007;

    public int numberOfBeautifulPartitions(int[] nums, int k, int minLength) {
        int n = nums.length;
        if (nums[0] % 2 == 0 || nums[n - 1] % 2 != 0) {
            return 0;
        }
        int[] prime = {2, 3, 5, 7};
        boolean[] beautiful = new boolean[n];
        for (int i = 0; i < n; i++) {
            for (int p : prime) {
                if (nums[i] % p == 0) {
                    beautiful[i] = true;
                    break;
                }
            }
        }

        int[][] dp = new int[n + 1][k + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int l = 1; l <= i; l++) {
                    if (i - l + 1 >= minLength && beautiful[i - 1] && (l == 1 || beautiful[l - 2])) {
                        dp[i][j] = (dp[i][j] + dp[l - 1][j - 1]) % MOD;
                    }
                }
            }
        }

        return dp[n][k];
    }
}