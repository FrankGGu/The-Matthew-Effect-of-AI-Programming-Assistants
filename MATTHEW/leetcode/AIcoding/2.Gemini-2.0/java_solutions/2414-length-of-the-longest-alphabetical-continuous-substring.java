class Solution {
    public int longestContinuousSubstring(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) - s.charAt(i - 1) == 1) {
                currentLen++;
            } else {
                maxLen = Math.max(maxLen, currentLen);
                currentLen = 1;
            }
        }

        maxLen = Math.max(maxLen, currentLen);

        return maxLen;
    }
}