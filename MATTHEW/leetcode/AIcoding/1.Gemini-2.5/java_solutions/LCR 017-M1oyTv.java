class Solution {
    public String minWindow(String s, String t) {
        if (t.isEmpty()) {
            return "";
        }

        int[] targetCounts = new int[128]; // Frequency map for characters in t
        for (char c : t.toCharArray()) {
            targetCounts[c]++;
        }

        int left = 0;
        int right = 0;
        int matchedChars = 0; // Number of characters from t (including duplicates) that are currently matched in the window

        int minLen = Integer.MAX_VALUE;
        int minStart = 0;

        int[] windowCounts = new int[128]; // Frequency map for characters in the current window

        while (right < s.length()) {
            char charR = s.charAt(right);
            windowCounts[charR]++;

            // If charR is a character needed by t AND its count in the window
            // has not yet exceeded its required count in t, then it contributes to matchedChars.
            if (targetCounts[charR] > 0 && windowCounts[charR] <= targetCounts[charR]) {
                matchedChars++;
            }

            // When all characters from t are matched in the current window
            while (matchedChars == t.length()) {
                // Update minimum window found so far
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    minStart = left;
                }

                char charL = s.charAt(left);
                windowCounts[charL]--;

                // If charL is a character needed by t AND its count in the window
                // drops below its required count in t, then it no longer contributes to matchedChars.
                if (targetCounts[charL] > 0 && windowCounts[charL] < targetCounts[charL]) {
                    matchedChars--;
                }
                left++;
            }
            right++;
        }

        if (minLen == Integer.MAX_VALUE) {
            return "";
        } else {
            return s.substring(minStart, minStart + minLen);
        }
    }
}