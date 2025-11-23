class Solution {
    public int lengthOfLongestSubstring(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        int[] charIndex = new int[128]; // Stores the last seen index + 1 for each character. 0 means not seen.
        int maxLength = 0;
        int left = 0; // Left pointer of the sliding window

        for (int right = 0; right < s.length(); right++) {
            char currentChar = s.charAt(right);

            // If the character was seen before within the current window,
            // its last seen index (stored as charIndex[currentChar] - 1) will be >= left.
            // We need to move the left pointer to one position after its last occurrence.
            // We use Math.max to ensure 'left' only moves forward,
            // preventing it from going backward if an old duplicate is found outside the current window.
            left = Math.max(left, charIndex[currentChar]);

            // Update the last seen index for the current character (store right + 1)
            charIndex[currentChar] = right + 1;

            // Calculate the current window length and update maxLength
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}