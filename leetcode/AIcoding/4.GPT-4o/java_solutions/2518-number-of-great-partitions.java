class Solution {
    public int countPartitions(int n, int k) {
        int mod = 1000000007;
        int totalSum = n * (n + 1) / 2;
        if (totalSum < k) return 0;

        int target = totalSum - k;
        if (target % 2 != 0) return 0;
        target /= 2;

        int[] dp = new int[target + 1];
        dp[0] = 1;

        for (int num = 1; num <= n; num++) {
            for (int j = target; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % mod;
            }
        }

        return dp[target];
    }
}