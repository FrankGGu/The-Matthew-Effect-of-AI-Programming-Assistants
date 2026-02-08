class Solution {
    public int maximizeMoney(int[] amount) {
        int n = amount.length;
        if (n == 0) return 0;
        if (n == 1) return amount[0];

        int[] dp = new int[n];
        dp[0] = amount[0];
        dp[1] = Math.max(amount[0], amount[1]);

        for (int i = 2; i < n; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + amount[i]);
        }

        return dp[n - 1];
    }
}