public class Solution {
    public int findSubstringInWrapup(String s) {
        int[] dp = new int[26];
        int maxLen = 0;
        for (int i = 0; i < s.length(); i++) {
            if (i > 0 && (s.charAt(i) - s.charAt(i - 1) == 1 || s.charAt(i - 1) - s.charAt(i) == 25)) {
                dp[s.charAt(i) - 'a'] = dp[s.charAt(i - 1) - 'a'] + 1;
            } else {
                dp[s.charAt(i) - 'a'] = 1;
            }
            maxLen = Math.max(maxLen, dp[s.charAt(i) - 'a']);
        }
        return maxLen;
    }
}