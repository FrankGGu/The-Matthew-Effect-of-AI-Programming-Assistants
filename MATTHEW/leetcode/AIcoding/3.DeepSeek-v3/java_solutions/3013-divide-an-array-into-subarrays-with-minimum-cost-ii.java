class Solution {
    public long minCost(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n + 1];
        Arrays.fill(dp, Long.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            int[] freq = new int[n];
            int unique = 0;
            for (int j = i - 1; j >= 0; j--) {
                int num = nums[j];
                freq[num]++;
                if (freq[num] == 1) {
                    unique++;
                } else if (freq[num] == 2) {
                    unique--;
                }
                long cost = k + (i - j) - unique;
                if (dp[j] != Long.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[j] + cost);
                }
            }
        }
        return dp[n];
    }
}