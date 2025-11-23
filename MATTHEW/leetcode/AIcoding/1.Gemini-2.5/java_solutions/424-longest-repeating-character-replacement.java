class Solution {
    public int characterReplacement(String s, int k) {
        int n = s.length();
        int[] charCounts = new int[26];
        int left = 0;
        int maxLength = 0;
        int maxFrequency = 0;

        for (int right = 0; right < n; right++) {
            char currentChar = s.charAt(right);
            charCounts[currentChar - 'A']++;
            maxFrequency = Math.max(maxFrequency, charCounts[currentChar - 'A']);

            if ((right - left + 1) - maxFrequency > k) {
                char charToRemove = s.charAt(left);
                charCounts[charToRemove - 'A']--;
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}