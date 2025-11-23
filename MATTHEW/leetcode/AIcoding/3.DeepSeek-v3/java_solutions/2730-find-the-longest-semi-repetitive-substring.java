class Solution {
    public int longestSemiRepetitiveSubstring(String s) {
        int maxLen = 1;
        int left = 0;
        int sameCount = 0;

        for (int right = 1; right < s.length(); right++) {
            if (s.charAt(right) == s.charAt(right - 1)) {
                sameCount++;
            }
            while (sameCount > 1) {
                if (s.charAt(left) == s.charAt(left + 1)) {
                    sameCount--;
                }
                left++;
            }
            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}