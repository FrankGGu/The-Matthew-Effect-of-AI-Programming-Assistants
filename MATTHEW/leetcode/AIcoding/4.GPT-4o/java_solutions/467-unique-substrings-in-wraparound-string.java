class Solution {
    public int findSubstringInWraproundString(String p) {
        int[] dp = new int[26];
        int maxLen = 0;

        for (int i = 0; i < p.length(); i++) {
            if (i > 0 && (p.charAt(i) - p.charAt(i - 1) + 26) % 26 == 1) {
                maxLen++;
            } else {
                maxLen = 1;
            }
            dp[p.charAt(i) - 'a'] = Math.max(dp[p.charAt(i) - 'a'], maxLen);
        }

        int result = 0;
        for (int count : dp) {
            result += count;
        }

        return result;
    }
}