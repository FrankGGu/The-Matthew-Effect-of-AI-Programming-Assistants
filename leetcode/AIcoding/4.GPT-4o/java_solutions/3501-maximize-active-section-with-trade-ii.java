class Solution {
    public int maximizeActiveSections(int[] sections) {
        int n = sections.length;
        int[] dp = new int[n + 1];
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; j++) {
                if (sections[j] < sections[i - 1]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
        }
        return dp[n];
    }
}