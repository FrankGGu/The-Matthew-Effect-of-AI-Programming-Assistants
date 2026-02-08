public class Solution {
    public int distinctSubseqA(String s) {
        int mod = 1000000007;
        int[] dp = new int[s.length() + 1];
        dp[0] = 1;
        int[] last = new int[26];
        for (int i = 0; i < 26; i++) {
            last[i] = -1;
        }
        for (int i = 1; i <= s.length(); i++) {
            char c = s.charAt(i - 1);
            int index = c - 'a';
            if (last[index] == -1) {
                dp[i] = (dp[i - 1] * 2) % mod;
            } else {
                dp[i] = (dp[i - 1] * 2 - dp[last[index]]) % mod;
            }
            last[index] = i - 1;
        }
        return dp[s.length()];
    }
}