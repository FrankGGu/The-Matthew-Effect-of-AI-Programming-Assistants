class Solution {
    public boolean splitArraySameAverage(int[] nums) {
        int n = nums.length;
        if (n == 1) return false;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        for (int i = 1; i < n; i++) {
            if ((sum * i) % n == 0) {
                int target = (sum * i) / n;
                if (canPartition(nums, i, target)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean canPartition(int[] nums, int k, int target) {
        int n = nums.length;
        boolean[][] dp = new boolean[n + 1][target + 1];
        for (int i = 0; i <= n; i++) {
            dp[i][0] = true;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= target; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1]) {
                    dp[i][j] = dp[i][j] || dp[i - 1][j - nums[i - 1]];
                }
            }
        }

        if (!dp[n][target]) return false;

        boolean[][][] dp2 = new boolean[n + 1][k + 1][target + 1];
        for (int i = 0; i <= n; i++) {
            dp2[i][0][0] = true;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                for (int l = 0; l <= target; l++) {
                    dp2[i][j][l] = dp2[i - 1][j][l];
                    if (l >= nums[i - 1]) {
                        dp2[i][j][l] = dp2[i][j][l] || dp2[i - 1][j - 1][l - nums[i - 1]];
                    }
                }
            }
        }

        return dp2[n][k][target];
    }
}