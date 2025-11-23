public class Solution {
    public int longestSemiRepetitiveSubstring(String s) {
        int n = s.length();
        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = i; j < n; j++) {
                if (j > 0 && s.charAt(j) == s.charAt(j - 1)) {
                    count++;
                }
                if (count <= 1) {
                    maxLen = Math.max(maxLen, j - i + 1);
                } else {
                    break;
                }
            }
        }
        return maxLen;
    }
}