class Solution {
    public int minSubstringLength(String s) {
        int n = s.length();
        int result = Integer.MAX_VALUE;

        for (char c = 'a'; c <= 'z'; c++) {
            int[] count = new int[26];
            int uniqueChars = 0;
            int requiredCount = 0;

            for (int i = 0; i < n; i++) {
                count[s.charAt(i) - 'a']++;
                if (count[s.charAt(i) - 'a'] == 1) {
                    uniqueChars++;
                }
                if (s.charAt(i) == c) {
                    requiredCount++;
                }
            }

            if (requiredCount == 0) continue;

            int left = 0;
            int right = 0;
            int currentCount = 0;

            while (right < n) {
                if (count[s.charAt(right) - 'a'] > 0 && (s.charAt(right) == c || count[s.charAt(right) - 'a'] == 1)) {
                    currentCount++;
                }

                while (currentCount == uniqueChars) {
                    if (count[s.charAt(left) - 'a'] > 0 && (s.charAt(left) == c || count[s.charAt(left) - 'a'] == 1)) {
                        currentCount--;
                    }
                    result = Math.min(result, right - left + 1);
                    left++;
                }
                right++;
            }
        }

        return result == Integer.MAX_VALUE ? 0 : result;
    }
}