import java.util.Arrays;

class Solution {
    public int longestAwesome(String s) {
        int n = s.length();
        // firstOccurrence[mask] stores the smallest index 'i' such that the prefix s[0...i-1]
        // has a parity mask 'mask'.
        // Initialize with -1, meaning not seen yet.
        // The maximum mask value for 10 digits (0-9) is 2^10 - 1 = 1023.
        int[] firstOccurrence = new int[1 << 10];
        Arrays.fill(firstOccurrence, -1);

        // Initialize for an empty prefix (before index 0) having a mask of 0.
        // This allows calculating awesome substrings starting from index 0.
        firstOccurrence[0] = -1;

        int maxLength = 0;
        int currentMask = 0; // Represents the parity mask for the prefix s[0...i]

        for (int i = 0; i < n; i++) {
            int digit = s.charAt(i) - '0';
            // Toggle the bit corresponding to the current digit.
            currentMask ^= (1 << digit);

            // Case 1: The substring s[j...i] is awesome because all digits appear an even number of times.
            // This means currentMask ^ mask_of_prefix_s[0...j-1] == 0.
            // So, mask_of_prefix_s[0...j-1] == currentMask.
            if (firstOccurrence[currentMask] != -1) {
                maxLength = Math.max(maxLength, i - firstOccurrence[currentMask]);
            }

            // Case 2: The substring s[j...i] is awesome because exactly one digit appears an odd number of times.
            // This means currentMask ^ mask_of_prefix_s[0...j-1] == (1 << k) for some k.
            // So, mask_of_prefix_s[0...j-1] == currentMask ^ (1 << k).
            for (int k = 0; k < 10; k++) {
                int targetMask = currentMask ^ (1 << k);
                if (firstOccurrence[targetMask] != -1) {
                    maxLength = Math.max(maxLength, i - firstOccurrence[targetMask]);
                }
            }

            // Store the first occurrence of the currentMask if it hasn't been seen before.
            if (firstOccurrence[currentMask] == -1) {
                firstOccurrence[currentMask] = i;
            }
        }

        return maxLength;
    }
}