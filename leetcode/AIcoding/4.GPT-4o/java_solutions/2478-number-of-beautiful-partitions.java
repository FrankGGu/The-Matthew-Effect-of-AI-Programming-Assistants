class Solution {
    public int countBeautifulPartitions(String s, int k, int minLength) {
        int mod = 1000000007;
        int n = s.length();
        if (n < k * minLength) return 0;

        long[][] dp = new long[k + 1][n + 1];
        long[] prefix = new long[n + 1];

        dp[0][0] = 1;
        prefix[0] = 1;

        for (int i = 1; i <= k; i++) {
            for (int j = 0; j <= n; j++) {
                if (j >= minLength && isValidPartition(s, j - minLength, j - 1)) {
                    dp[i][j] = (dp[i][j] + prefix[j - minLength]) % mod;
                }
            }
            for (int j = 0; j <= n; j++) {
                prefix[j] = (prefix[j] + dp[i][j]) % mod;
            }
        }

        return (int) dp[k][n];
    }

    private boolean isValidPartition(String s, int start, int end) {
        return s.charAt(start) == '2' && s.charAt(end) == '3';
    }
}