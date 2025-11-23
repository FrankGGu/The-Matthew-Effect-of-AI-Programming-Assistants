class Solution {
    public int solve(String s, int k) {
        int n = s.length();

        // dp[i][j] represents the maximum total length using j disjoint special substrings
        // chosen from the prefix s[0...i-1].
        // i ranges from 0 to n (exclusive end index for substring selection).
        // j ranges from 0 to k (number of substrings).
        int[][] dp = new int[n + 1][k + 1];

        // Initialize dp table.
        // dp[i][0] = 0 for all i, as 0 length can be achieved with 0 substrings.
        // All other dp[i][j] (where j > 0) are initialized to -1,
        // indicating that it's not possible to form j substrings with that configuration yet.
        for (int i = 0; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = -1; // Represents an impossible state
            }
        }

        // Fill the dp table
        for (int i = 1; i <= n; i++) { // Current end index (exclusive) for substrings, considering s[0...i-1]
            for (int j = 1; j <= k; j++) { // Number of disjoint special substrings to select
                // Option 1: Do not include any special substring ending at s[i-1].
                // In this case, dp[i][j] is the same as the maximum length achieved considering s[0...i-2].
                dp[i][j] = dp[i-1][j];

                // Option 2: Try to include a special substring s[p...i-1] that ends at s[i-1].
                int zeros = 0;
                int ones = 0;
                // Iterate 'p' backwards from 'i-1' to '0' to find all special substrings ending at 'i-1'.
                for (int p = i - 1; p >= 0; p--) { 
                    if (s.charAt(p) == '0') {
                        zeros++;
                    } else {
                        ones++;
                    }

                    if (zeros == ones) {
                        // s[p...i-1] is a special substring.
                        int currentSubstrLength = i - p; // Length is (i-1) - p + 1

                        // To include this substring, we must have formed (j-1) disjoint special substrings
                        // from the prefix s[0...p-1]. This value is stored in dp[p][j-1].
                        if (dp[p][j-1] != -1) { // Check if it's possible to form j-1 substrings before 'p'
                            dp[i][j] = Math.max(dp[i][j], dp[p][j-1] + currentSubstrLength);
                        }
                    }
                }
            }
        }

        // The result is the maximum total length for K disjoint special substrings considering the whole string s.
        // If dp[n][k] is -1, it means no such K substrings can be formed, in which case the problem asks for 0.
        return Math.max(0, dp[n][k]);
    }
}