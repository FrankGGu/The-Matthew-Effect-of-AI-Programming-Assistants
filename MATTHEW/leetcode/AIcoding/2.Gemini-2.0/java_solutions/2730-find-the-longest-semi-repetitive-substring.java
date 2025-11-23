class Solution {
    public int longestSemiRepetitiveSubstring(String s) {
        int n = s.length();
        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                if (isSemiRepetitive(sub)) {
                    maxLen = Math.max(maxLen, sub.length());
                }
            }
        }
        return maxLen;
    }

    private boolean isSemiRepetitive(String s) {
        int consecutiveCount = 0;
        for (int i = 0; i < s.length() - 1; i++) {
            if (s.charAt(i) == s.charAt(i + 1)) {
                consecutiveCount++;
            }
        }
        return consecutiveCount <= 1;
    }
}