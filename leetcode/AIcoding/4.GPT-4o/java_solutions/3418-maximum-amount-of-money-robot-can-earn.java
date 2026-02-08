class Solution {
    public int rob(int[] money) {
        int n = money.length;
        if (n == 0) return 0;
        if (n == 1) return money[0];

        int[] dp = new int[n];
        dp[0] = money[0];
        dp[1] = Math.max(money[0], money[1]);

        for (int i = 2; i < n; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + money[i]);
        }

        return dp[n - 1];
    }
}