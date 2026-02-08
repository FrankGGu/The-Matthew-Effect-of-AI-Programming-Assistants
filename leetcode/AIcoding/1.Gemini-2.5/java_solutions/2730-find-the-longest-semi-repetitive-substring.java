class Solution {
    public int longestSemiRepetitiveSubstring(String s) {
        int n = s.length();
        int maxLen = 0; 
        int left = 0;
        int countAdjacentPairs = 0;

        for (int right = 0; right < n; right++) {
            if (right > 0 && s.charAt(right) == s.charAt(right - 1)) {
                countAdjacentPairs++;
            }

            while (countAdjacentPairs > 2) {
                if (s.charAt(left) == s.charAt(left + 1)) {
                    countAdjacentPairs--;
                }
                left++;
            }

            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}