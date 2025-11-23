class Solution {
    public int numberOfArrays(String s, int k) {
        int mod = 1000000007;
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 10 && i - j >= 0; j++) {
                String sub = s.substring(i - j, i);
                if (sub.charAt(0) == '0' || Long.parseLong(sub) > k) {
                    break;
                }
                dp[i] = (dp[i] + dp[i - j]) % mod;
            }
        }

        return (int) dp[n];
    }
}