public class Solution {
    public int distinctSubseqA(String s) {
        int MOD = 1000000007;
        int[] dp = new int[s.length() + 1];
        dp[0] = 1;
        int[] last = new int[256];
        for (int i = 0; i < 256; i++) {
            last[i] = -1;
        }
        for (int i = 1; i <= s.length(); i++) {
            char c = s.charAt(i - 1);
            dp[i] = (dp[i - 1] * 2) % MOD;
            if (last[c] != -1) {
                dp[i] = (dp[i] - dp[last[c]] + MOD) % MOD;
            }
            last[c] = i - 1;
        }
        return dp[s.length()];
    }
}