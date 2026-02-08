class Solution {
    public int distinctSubseqII(String s) {
        int MOD = 1_000_000_007;
        int n = s.length();
        int[] dp = new int[n + 1];
        dp[0] = 1;
        int[] last = new int[26];
        Arrays.fill(last, -1);

        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            dp[i + 1] = dp[i] * 2 % MOD;
            if (last[c] != -1) {
                dp[i + 1] = (dp[i + 1] - dp[last[c]] + MOD) % MOD;
            }
            last[c] = i;
        }

        return (dp[n] - 1) % MOD;
    }
}