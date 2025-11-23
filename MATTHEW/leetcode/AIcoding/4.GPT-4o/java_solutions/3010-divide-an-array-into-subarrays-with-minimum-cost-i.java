class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                int[] freq = new int[101];
                int uniqueCount = 0;
                for (int m = i; m > 0; m--) {
                    int num = nums[m - 1];
                    if (freq[num] == 0) uniqueCount++;
                    freq[num]++;
                    dp[i][j] = Math.min(dp[i][j], dp[m - 1][j - 1] + uniqueCount);
                }
            }
        }

        return dp[n][k];
    }
}