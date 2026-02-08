class Solution {
    public int longestContinuousSubstring(String s) {
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) - s.charAt(i - 1) == 1) {
                currentLen++;
                maxLen = Math.max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }

        return maxLen;
    }
}