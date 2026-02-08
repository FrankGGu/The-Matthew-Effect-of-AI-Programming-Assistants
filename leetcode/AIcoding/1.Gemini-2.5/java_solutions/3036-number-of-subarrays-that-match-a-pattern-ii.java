class Solution {
    public int countMatchingSubarrays(int[] nums, int[] pattern) {
        int n = nums.length;
        int m = pattern.length;

        // If the transformed array (text) would be shorter than the pattern, no match is possible.
        // The transformed array will have length n-1.
        if (n - 1 < m) {
            return 0;
        }

        // Step 1: Transform nums into a new array representing relationships between adjacent elements.
        // This transformed array will serve as the 'text' for the KMP algorithm.
        int[] transformedNums = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] < nums[i + 1]) {
                transformedNums[i] = -1;
            } else if (nums[i] > nums[i + 1]) {
                transformedNums[i] = 1;
            } else {
                transformedNums[i] = 0;
            }
        }

        // Step 2: Use the KMP algorithm to find occurrences of the pattern in the transformedNums array.
        return kmpSearch(transformedNums, pattern);
    }

    // KMP search function
    private int kmpSearch(int[] text, int[] pattern) {
        int N = text.length;
        int M = pattern.length;

        // Compute the Longest Proper Prefix Suffix (LPS) array for the pattern.
        // The LPS array helps to avoid redundant comparisons when a mismatch occurs.
        int[] lps = computeLPSArray(pattern);

        int count = 0; // Stores the number of times pattern occurs in text
        int i = 0;     // Index for text[]
        int j = 0;     // Index for pattern[]

        while (i < N) {
            if (pattern[j] == text[i]) {
                i++;
                j++;
            }

            if (j == M) {
                // Pattern found at text[i-j ... i-1]
                count++;
                // Shift the pattern using the LPS array to find next possible match
                j = lps[j - 1];
            } else if (i < N && pattern[j] != text[i]) {
                // Mismatch after j matches
                if (j != 0) {
                    // Do not match lps[0...lps[j-1]-1] characters,
                    // they will match anyway due to LPS property.
                    j = lps[j - 1];
                } else {
                    // If j is 0, no prefix matched, just move to the next character in text.
                    i++;
                }
            }
        }
        return count;
    }

    // Function to compute the LPS array for the given pattern
    private int[] computeLPSArray(int[] pattern) {
        int M = pattern.length;
        int[] lps = new int[M];
        int length = 0; // Length of the previous longest prefix suffix
        int i = 1;

        lps[0] = 0; // lps[0] is always 0

        // The loop calculates lps[i] for i = 1 to M-1
        while (i < M) {
            if (pattern[i] == pattern[length]) {
                length++;
                lps[i] = length;
                i++;
            } else { // (pattern[i] != pattern[length])
                if (length != 0) {
                    // This is tricky. We don't increment i here.
                    // We try to match pattern[i] with pattern[length-1]'s LPS value.
                    length = lps[length - 1];
                } else { // if (length == 0)
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}