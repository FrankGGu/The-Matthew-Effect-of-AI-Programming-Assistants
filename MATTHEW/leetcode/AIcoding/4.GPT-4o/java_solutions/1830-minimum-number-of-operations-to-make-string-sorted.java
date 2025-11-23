class Solution {
    public int minOperations(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = dp[i];
            while (dp[i] < i && s.charAt(dp[i]) <= s.charAt(i)) {
                dp[i + 1]++;
            }
        }
        return n - dp[n];
    }
}