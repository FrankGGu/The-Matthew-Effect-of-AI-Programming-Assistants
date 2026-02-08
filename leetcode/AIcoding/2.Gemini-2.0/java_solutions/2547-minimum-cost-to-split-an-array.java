class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            for (int j = i; j >= 1; j--) {
                int cost = k;
                int[] count = new int[n + 1];
                int trim = 0;
                for (int l = j; l <= i; l++) {
                    count[nums[l - 1]]++;
                    if (count[nums[l - 1]] == 2) {
                        trim += 2;
                    } else if (count[nums[l - 1]] > 2) {
                        trim++;
                    }
                }
                cost += trim;
                dp[i] = Math.min(dp[i], dp[j - 1] + cost);
            }
        }
        return dp[n];
    }
}