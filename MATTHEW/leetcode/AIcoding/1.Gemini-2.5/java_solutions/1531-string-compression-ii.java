import java.util.Arrays;

class Solution {

    // Helper function to calculate the length of a compressed segment
    private int getLength(int count) {
        if (count == 0) {
            return 0;
        }
        if (count == 1) {
            return 1;
        }
        if (count < 10) {
            return 2; // e.g., "a2"
        }
        if (count < 100) {
            return 3; // e.g., "a10"
        }
        return 4; // e.g., "a100"
    }

    public int getLengthOfOptimalCompression(String s, int k) {
        int n = s.length();
        // dp[i][j] represents the minimum length to compress the prefix s[0...i-1]
        // using exactly j deletions.
        int[][] dp = new int[n + 1][k + 1];

        // Initialize dp table with a large value (infinity)
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        // Base case: an empty prefix with 0 deletions has length 0
        dp[0][0] = 0;

        // Iterate through each character of the string
        for (int i = 1; i <= n; i++) {
            // Iterate through each possible number of deletions
            for (int j = 0; j <= k; j++) {
                // Option 1: Delete the current character s[i-1]
                // If we have deletions available, we can delete s[i-1]
                if (j > 0) {
                    dp[i][j] = dp[i-1][j-1];
                }

                // Option 2: Keep the current character s[i-1] and form a block
                // This block ends at s[i-1] and starts at some s[p] (where p < i)
                char currentChar = s.charAt(i-1);
                int sameCount = 0; // count of currentChar in the current segment s[p...i-1]
                int diffCount = 0; // count of other characters in the current segment (these will be deleted)

                // Iterate backwards from s[i-1] to find the start of the block
                for (int p = i - 1; p >= 0; p--) {
                    if (s.charAt(p) == currentChar) {
                        sameCount++;
                    } else {
                        diffCount++;
                    }

                    // If we have enough deletions to remove all 'diffCount' characters in s[p...i-1]
                    if (j >= diffCount) {
                        // Calculate the length of the previous part (s[0...p-1])
                        int prevLen = dp[p][j - diffCount];
                        if (prevLen != Integer.MAX_VALUE) {
                            // Update dp[i][j] with the minimum length
                            // current_segment_len = getLength(sameCount)
                            dp[i][j] = Math.min(dp[i][j], prevLen + getLength(sameCount));
                        }
                    }
                }
            }
        }

        // The problem asks for "at most k deletions".
        // So, we need to find the minimum among dp[n][0] to dp[n][k].
        int minLength = Integer.MAX_VALUE;
        for (int j = 0; j <= k; j++) {
            minLength = Math.min(minLength, dp[n][j]);
        }

        return minLength;
    }
}