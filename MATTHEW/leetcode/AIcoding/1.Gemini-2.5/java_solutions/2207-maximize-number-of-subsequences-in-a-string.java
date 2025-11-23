class Solution {
    public long maximumSubsequenceCount(String pattern, String text) {
        char c1 = pattern.charAt(0);
        char c2 = pattern.charAt(1);

        long originalSubsequenceCount = 0;
        long countC1 = 0; // Tracks the number of c1s encountered so far

        long totalC1Count = 0; // Total count of c1 in text
        long totalC2Count = 0; // Total count of c2 in text

        // Iterate through the text to calculate:
        // 1. The original number of c1c2 subsequences.
        // 2. The total count of c1s in text.
        // 3. The total count of c2s in text.
        for (char c : text.toCharArray()) {
            // If the current character is c2, it forms subsequences with all c1s seen before it.
            if (c == c2) {
                originalSubsequenceCount += countC1;
                totalC2Count++;
            }
            // If the current character is c1, increment its count for future c2s.
            if (c == c1) {
                countC1++;
                totalC1Count++;
            }
        }

        // Option 1: Insert an additional c1 character.
        // To maximize subsequences, this new c1 should be placed at the beginning of the text.
        // This new c1 will form a subsequence with every existing c2 in the text.
        // The number of new subsequences added is totalC2Count.
        // The existing originalSubsequenceCount remains unchanged.
        long result1 = originalSubsequenceCount + totalC2Count;

        // Option 2: Insert an additional c2 character.
        // To maximize subsequences, this new c2 should be placed at the end of the text.
        // This new c2 will form a subsequence with every existing c1 in the text.
        // The number of new subsequences added is totalC1Count.
        // The existing originalSubsequenceCount remains unchanged.
        long result2 = originalSubsequenceCount + totalC1Count;

        // The maximum number of subsequences is the greater of the two options.
        return Math.max(result1, result2);
    }
}