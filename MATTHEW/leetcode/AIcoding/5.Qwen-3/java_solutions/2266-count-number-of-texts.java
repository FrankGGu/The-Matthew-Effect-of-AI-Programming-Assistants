public class Solution {
    public int countTexts(String s, int[] keyboard) {
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 3 && i - j >= 0; j++) {
                int key = s.charAt(i - j) - 'a';
                if (keyboard[key] >= j) {
                    dp[i] += dp[i - j];
                    dp[i] %= 1000000007;
                }
            }
        }
        return (int) dp[n];
    }
}