import java.util.Arrays;

class Solution {
    public int maximizeTheNumberOfPartitions(String s) {
        int n = s.length();
        // dp[i][0] = max partitions for s[0...i-1] using 0 operations
        // dp[i][1] = max partitions for s[0...i-1] using 1 operation
        int[][] dp = new int[n + 1][2];

        // Initialize with a value indicating an unreachable state.
        // Using Integer.MIN_VALUE / 2 to prevent overflow when adding 1.
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MIN_VALUE / 2);
        }

        // Base case: 0 partitions for an empty prefix, with 0 or 1 operations used (effectively no operation applied yet).
        dp[0][0] = 0;
        dp[0][1] = 0;

        for (int i = 1; i <= n; i++) {
            // Calculate dp[i][0] (no operation used for s[0...i-1])
            int currentMask0 = 0; // Bitmask for unique characters in the current segment s[j...i-1]
            // A segment must have unique characters, so its length can be at most 26.
            for (int j = i - 1; j >= 0 && (i - j) <= 26; j--) {
                int charIdx = s.charAt(j) - 'a';
                if ((currentMask0 & (1 << charIdx)) != 0) {
                    // Character s.charAt(j) is already present in s[j+1...i-1], so s[j...i-1] is not unique.
                    break; 
                }
                currentMask0 |= (1 << charIdx);

                // If dp[j][0] is a reachable state, we can form a new partition.
                if (dp[j][0] > Integer.MIN_VALUE / 2) {
                    dp[i][0] = Math.max(dp[i][0], dp[j][0] + 1);
                }
            }

            // Calculate dp[i][1] (one operation used for s[0...i-1])
            int currentMask1 = 0; // Bitmask for characters in the current segment s[j...i-1]
            int duplicateCharsMask = 0; // Bitmask for characters that appear more than once in s[j...i-1]
            // A segment can be made unique with one operation if its length is at most 27 (26 unique + 1 duplicate).
            for (int j = i - 1; j >= 0 && (i - j) <= 27; j--) {
                int charIdx = s.charAt(j) - 'a';
                if ((currentMask1 & (1 << charIdx)) != 0) {
                    // If charIdx is already in currentMask1, it's a duplicate. Add it to duplicateCharsMask.
                    duplicateCharsMask |= (1 << charIdx);
                }
                currentMask1 |= (1 << charIdx);

                // Case 1: The operation was used in s[0...j-1].
                //   For this transition, the current segment s[j...i-1] must be unique WITHOUT any operation.
                //   This is true if duplicateCharsMask is empty (no duplicates).
                if (duplicateCharsMask == 0) {
                    if (dp[j][1] > Integer.MIN_VALUE / 2) { // If dp[j][1] is reachable
                        dp[i][1] = Math.max(dp[i][1], dp[j][1] + 1);
                    }
                }

                // Case 2: The operation is used within the current segment s[j...i-1].
                //   For this transition, s[0...j-1] must have used 0 operations (dp[j][0]).
                //   The current segment s[j...i-1] must be transformable into a unique segment with one operation.
                //   This is true if duplicateCharsMask has at most one bit set (meaning at most one character type is duplicated).
                if (Integer.bitCount(duplicateCharsMask) <= 1) {
                    if (dp[j][0] > Integer.MIN_VALUE / 2) { // If dp[j][0] is reachable
                        dp[i][1] = Math.max(dp[i][1], dp[j][0] + 1);
                    }
                } else {
                    // If duplicateCharsMask has more than one bit set, it means s[j...i-1] contains
                    // at least two distinct characters that appear more than once.
                    // One operation is not enough to make this segment unique.
                    // Therefore, we cannot extend this segment further back for dp[i][1].
                    break;
                }
            }
        }

        // The result is the maximum of partitions obtained with 0 or 1 operations on the entire string.
        return Math.max(dp[n][0], dp[n][1]);
    }
}