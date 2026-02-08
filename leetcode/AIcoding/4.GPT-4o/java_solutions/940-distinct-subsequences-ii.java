class Solution {
    public int distinctSubseqII(String s) {
        int MOD = 1000000007;
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;
        int[] last = new int[26];

        for (int i = 1; i <= n; i++) {
            dp[i] = (2 * dp[i - 1]) % MOD;
            int index = s.charAt(i - 1) - 'a';
            dp[i] = (dp[i] - last[index] + MOD) % MOD;
            last[index] = (int) dp[i - 1];
        }

        return (int) ((dp[n] - 1 + MOD) % MOD);
    }
}