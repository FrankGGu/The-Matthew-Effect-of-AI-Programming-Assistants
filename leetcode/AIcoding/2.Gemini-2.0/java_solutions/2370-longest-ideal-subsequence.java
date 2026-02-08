class Solution {
    public int longestIdealString(String s, int k) {
        int[] dp = new int[26];
        for (char c : s.toCharArray()) {
            int index = c - 'a';
            int maxLen = 0;
            for (int i = 0; i < 26; i++) {
                if (Math.abs(i - index) <= k) {
                    maxLen = Math.max(maxLen, dp[i]);
                }
            }
            dp[index] = maxLen + 1;
        }
        int result = 0;
        for (int len : dp) {
            result = Math.max(result, len);
        }
        return result;
    }
}