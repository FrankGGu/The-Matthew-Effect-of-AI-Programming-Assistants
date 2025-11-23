class Solution {
    public int maxRepOpt1(String text) {
        int n = text.length();
        if (n == 0) {
            return 0;
        }

        int[] counts = new int[26];
        for (char c : text.toCharArray()) {
            counts[c - 'a']++;
        }

        int maxLen = 0;
        int i = 0;
        while (i < n) {
            // Find the current contiguous block
            int j = i;
            while (j < n && text.charAt(j) == text.charAt(i)) {
                j++;
            }
            int len1 = j - i; // Length of the first block

            // Case 1: Extend the current block by 1 by swapping a different character
            // This is possible if there's at least one more character of the same type available elsewhere
            maxLen = Math.max(maxLen, len1); // Initial max without any swap
            if (counts[text.charAt(i) - 'a'] > len1) {
                maxLen = Math.max(maxLen, len1 + 1);
            }

            // Case 2: Merge two blocks of the same character separated by exactly one different character
            // Check if there's a single character gap
            int k = j + 1;
            if (k < n) {
                // Find the next block of the same character
                int l = k;
                while (l < n && text.charAt(l) == text.charAt(i)) {
                    l++;
                }
                int len2 = l - k; // Length of the second block

                // If a second block of the same character was found
                if (len2 > 0) {
                    int totalMergedLen = len1 + len2;
                    // If there are more characters of this type available than what's in the two blocks,
                    // we can use one to bridge the gap and get totalMergedLen + 1.
                    // Otherwise, we can only get totalMergedLen (by effectively swapping one from the blocks into the gap,
                    // which means we use all available characters of that type).
                    maxLen = Math.max(maxLen, totalMergedLen + (counts[text.charAt(i) - 'a'] > totalMergedLen ? 1 : 0));
                }
            }

            i = j; // Move to the start of the next block
        }

        return maxLen;
    }
}