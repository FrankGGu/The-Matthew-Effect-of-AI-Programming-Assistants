class Solution {
    public int minimumDeletions(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        for (int i = n - 1; i >= 0; i--) {
            dp[i] = dp[i + 1] + (s.charAt(i) == '0' ? 0 : 1);
            int j = i + 1;
            while (j <= n && s.charAt(j - 1) == '1') {
                dp[i] = Math.min(dp[i], dp[j] + (j - i - 1));
                j++;
            }
        }
        return dp[0];
    }
}