class Solution {
    public int findValidSplit(int[] nums) {
        int n = nums.length;
        int[] last = new int[100001];
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            last[nums[i]] = i + 1;
            for (int j = 0; j <= i; j++) {
                if (dp[j] < Integer.MAX_VALUE) {
                    dp[i + 1] = Math.min(dp[i + 1], dp[j] + 1);
                }
                if (last[nums[j]] > j) {
                    j = last[nums[j]] - 1;
                }
            }
            dp[i + 1] = Math.min(dp[i + 1], dp[i] + 1);
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n] - 1;
    }
}