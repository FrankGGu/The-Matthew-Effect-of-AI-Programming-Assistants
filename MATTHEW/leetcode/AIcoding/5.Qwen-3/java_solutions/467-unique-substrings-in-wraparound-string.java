public class Solution {
    public int findSubstringInWrapup(String p) {
        int[] dp = new int[26];
        int maxLen = 0;
        for (int i = 0; i < p.length(); i++) {
            if (i > 0 && (p.charAt(i) - p.charAt(i - 1) == 1 || p.charAt(i - 1) - p.charAt(i) == 25)) {
                maxLen++;
            } else {
                maxLen = 1;
            }
            int index = p.charAt(i) - 'a';
            if (maxLen > dp[index]) {
                dp[index] = maxLen;
            }
        }
        int result = 0;
        for (int count : dp) {
            result += count;
        }
        return result;
    }
}