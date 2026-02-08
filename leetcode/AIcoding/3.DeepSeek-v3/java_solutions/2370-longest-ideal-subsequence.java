class Solution {
    public int longestIdealString(String s, int k) {
        int[] dp = new int[26];
        int maxLen = 0;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            int current = c - 'a';
            int max = 0;

            for (int j = Math.max(0, current - k); j <= Math.min(25, current + k); j++) {
                max = Math.max(max, dp[j]);
            }

            dp[current] = max + 1;
            maxLen = Math.max(maxLen, dp[current]);
        }

        return maxLen;
    }
}