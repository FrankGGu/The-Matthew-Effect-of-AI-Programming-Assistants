class Solution {
    public int longestSemiRepetitiveSubstring(String s) {
        int n = s.length();
        int left = 0, right = 0;
        int count = 0, maxLength = 0;

        while (right < n) {
            if (right > 0 && s.charAt(right) == s.charAt(right - 1)) {
                count++;
            }
            while (count > 1) {
                if (s.charAt(left) == s.charAt(left + 1)) {
                    count--;
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }

        return maxLength;
    }
}