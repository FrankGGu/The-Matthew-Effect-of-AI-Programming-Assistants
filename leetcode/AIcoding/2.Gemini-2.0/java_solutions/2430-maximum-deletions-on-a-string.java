class Solution {
    public int deleteString(String s) {
        int n = s.length();
        int[] dp = new int[n];
        for (int i = n - 1; i >= 0; i--) {
            dp[i] = 1;
            for (int j = i + 1; j < n; j++) {
                int len = j - i;
                if (i + 2 * len > n) continue;
                if (s.substring(i, i + len).equals(s.substring(i + len, i + 2 * len))) {
                    dp[i] = Math.max(dp[i], 1 + dp[j]);
                }
            }
        }
        return dp[0];
    }
}