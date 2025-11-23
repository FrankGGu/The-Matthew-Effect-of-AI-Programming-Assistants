class Solution {
    public int longestSubstring(String s, int k) {
        return longestSubstringRecursive(s, k, 0, s.length() - 1);
    }

    private int longestSubstringRecursive(String s, int k, int start, int end) {
        if (end - start + 1 < k) {
            return 0;
        }

        int[] charCounts = new int[26];
        for (int i = start; i <= end; i++) {
            charCounts[s.charAt(i) - 'a']++;
        }

        // Find a character that appears less than k times
        // If all characters appear at least k times, the current substring is valid
        boolean allCharsValid = true;
        for (int i = 0; i < 26; i++) {
            // Only consider characters that are present in the current substring
            if (charCounts[i] > 0 && charCounts[i] < k) {
                allCharsValid = false;
                break;
            }
        }

        if (allCharsValid) {
            return end - start + 1;
        }

        // If not all characters are valid, we need to split the string
        int maxLen = 0;
        int currentSegmentStart = start;
        for (int i = start; i <= end; i++) {
            if (charCounts[s.charAt(i) - 'a'] < k) {
                // This character is invalid, so it acts as a separator
                if (i > currentSegmentStart) { // Process the segment before this invalid character
                    maxLen = Math.max(maxLen, longestSubstringRecursive(s, k, currentSegmentStart, i - 1));
                }
                currentSegmentStart = i + 1; // Start a new segment after this invalid character
            }
        }
        // Process the last segment after the last invalid character (if it exists)
        if (currentSegmentStart <= end) {
            maxLen = Math.max(maxLen, longestSubstringRecursive(s, k, currentSegmentStart, end));
        }

        return maxLen;
    }
}