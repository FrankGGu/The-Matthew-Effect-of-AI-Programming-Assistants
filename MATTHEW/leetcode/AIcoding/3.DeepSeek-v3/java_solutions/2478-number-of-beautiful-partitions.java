class Solution {
    private static final int MOD = 1_000_000_007;

    public int beautifulPartitions(String s, int k, int minLength) {
        int n = s.length();
        if (k * minLength > n || !isPrime(s.charAt(0)) {
            return 0;
        }
        int[][] dp = new int[k + 1][n + 1];
        dp[0][0] = 1;
        for (int i = 1; i <= k; i++) {
            int sum = 0;
            for (int j = i * minLength; j <= n; j++) {
                if (j - minLength >= 0 && isPrime(s.charAt(j - minLength))) {
                    sum = (sum + dp[i - 1][j - minLength]) % MOD;
                }
                if (j >= 1 && !isPrime(s.charAt(j - 1))) {
                    dp[i][j] = sum;
                }
            }
        }
        return dp[k][n];
    }

    private boolean isPrime(char c) {
        return c == '2' || c == '3' || c == '5' || c == '7';
    }
}