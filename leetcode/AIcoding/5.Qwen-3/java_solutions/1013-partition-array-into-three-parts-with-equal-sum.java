public class Solution {
    public int splitArraySameAverage(int[] nums) {
        int n = nums.length;
        int m = n / 2;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        boolean[][] dp = new boolean[m + 1][sum + 1];
        dp[0][0] = true;
        for (int num : nums) {
            for (int i = m; i > 0; i--) {
                for (int j = 0; j <= sum - num; j++) {
                    if (dp[i - 1][j]) {
                        dp[i][j + num] = true;
                    }
                }
            }
        }
        for (int i = 1; i <= m; i++) {
            if (sum * i % n == 0 && dp[i][sum * i / n]) {
                return 1;
            }
        }
        return 0;
    }
}