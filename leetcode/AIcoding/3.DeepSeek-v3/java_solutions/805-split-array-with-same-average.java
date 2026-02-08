class Solution {
    public boolean splitArraySameAverage(int[] nums) {
        int n = nums.length;
        if (n == 1) return false;
        int sum = 0;
        for (int num : nums) sum += num;
        boolean[][] dp = new boolean[sum + 1][n / 2 + 1];
        dp[0][0] = true;
        for (int num : nums) {
            for (int i = sum; i >= num; i--) {
                for (int j = 1; j <= n / 2; j++) {
                    if (dp[i - num][j - 1]) {
                        dp[i][j] = true;
                    }
                }
            }
        }
        for (int k = 1; k <= n / 2; k++) {
            if (sum * k % n == 0) {
                int target = sum * k / n;
                if (target <= sum && dp[target][k]) return true;
            }
        }
        return false;
    }
}