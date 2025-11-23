class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        // Calculate the total number of '0's in the string.
        int totalZerosCount = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                totalZerosCount++;
            }
        }

        // minFlips will store the minimum number of flips found.
        // Initialize it with the cost of making the entire string '1's.
        // This corresponds to a split point k=0 (all '1's), where all '0's must be flipped to '1's.
        int minFlips = totalZerosCount;

        // onesInPrefix: counts '1's in the current prefix s[0...i]. These '1's would need to be flipped if the prefix becomes '0's.
        // zerosInPrefix: counts '0's in the current prefix s[0...i].
        int onesInPrefix = 0;
        int zerosInPrefix = 0;

        // Iterate through all possible split points.
        // 'i' represents the last index of the '0's part.
        // So, s[0...i] should be '0's, and s[i+1...n-1] should be '1's.
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                zerosInPrefix++;
            } else {
                onesInPrefix++;
            }

            // Calculate flips for the current split:
            // 1. Flips needed for the prefix s[0...i] to become all '0's: `onesInPrefix` (flip '1's to '0's).
            // 2. Flips needed for the suffix s[i+1...n-1] to become all '1's:
            //    This is `(total number of '0's in string) - (number of '0's in prefix s[0...i])`.
            //    Which is `totalZerosCount - zerosInPrefix`.
            int currentFlips = onesInPrefix + (totalZerosCount - zerosInPrefix);
            minFlips = Math.min(minFlips, currentFlips);
        }

        // The initial `minFlips = totalZerosCount` covers the case where the entire string is '1's (split point k=0).
        // The loop iterates through split points where the '0's part ends at index `i` (split point k=i+1).
        // When `i = n-1`, `onesInPrefix` will be the total '1's in the string,
        // and `totalZerosCount - zerosInPrefix` will be 0.
        // This effectively calculates the cost for the entire string to be '0's (split point k=n).
        // Thus, all possible split points are covered.

        return minFlips;
    }
}