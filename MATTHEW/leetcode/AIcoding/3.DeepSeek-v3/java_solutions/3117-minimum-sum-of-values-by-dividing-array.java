class Solution {
    public int minimumValueSum(int[] nums, int[] andValues) {
        int n = nums.length;
        int m = andValues.length;
        int[][] dp = new int[n + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                int currentAnd = nums[i - 1];
                for (int k = i; k >= 1; k--) {
                    currentAnd &= nums[k - 1];
                    if (currentAnd == andValues[j - 1]) {
                        if (dp[k - 1][j - 1] != Integer.MAX_VALUE / 2) {
                            dp[i][j] = Math.min(dp[i][j], dp[k - 1][j - 1] + nums[k - 1]);
                        }
                    } else if (currentAnd < andValues[j - 1]) {
                        break;
                    }
                }
            }
        }

        return dp[n][m] == Integer.MAX_VALUE / 2 ? -1 : dp[n][m];
    }
}