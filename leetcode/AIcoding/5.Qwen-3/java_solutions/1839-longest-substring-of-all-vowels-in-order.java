public class Solution {
    public int longestSubstring(String s) {
        int n = s.length();
        int maxLen = 0;
        int[] dp = new int[n];

        for (int i = 0; i < n; i++) {
            if (i == 0) {
                dp[i] = 1;
            } else {
                if (isOrdered(s.charAt(i - 1), s.charAt(i))) {
                    dp[i] = dp[i - 1] + 1;
                } else {
                    dp[i] = 1;
                }
            }
            maxLen = Math.max(maxLen, dp[i]);
        }

        return maxLen;
    }

    private boolean isOrdered(char prev, char curr) {
        if (prev == 'a' && curr == 'a') return true;
        if (prev == 'a' && curr == 'e') return true;
        if (prev == 'e' && curr == 'e') return true;
        if (prev == 'e' && curr == 'i') return true;
        if (prev == 'i' && curr == 'i') return true;
        if (prev == 'i' && curr == 'o') return true;
        if (prev == 'o' && curr == 'o') return true;
        if (prev == 'o' && curr == 'u') return true;
        if (prev == 'u' && curr == 'u') return true;
        return false;
    }
}