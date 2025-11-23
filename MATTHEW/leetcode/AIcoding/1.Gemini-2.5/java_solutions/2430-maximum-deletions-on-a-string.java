class Solution {
    public int longestDecomposition(String s) {
        int n = s.length();
        int[][] lcp = new int[n + 1][n + 1];

        // Precompute LCP (Longest Common Prefix) array
        // lcp[i][j] stores the length of the longest common prefix of s[i...] and s[j...]
        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (s.charAt(i) == s.charAt(j)) {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        int[] dp = new int[n + 1];
        dp[n] = 0; // Base case: an empty string requires 0 operations

        // Fill DP table from right to left
        for (int i = n - 1; i >= 0; i--) {
            // Option 1: Delete the current character s[i]
            // This always costs 1 operation, and we solve for the rest of the string s[i+1...]
            dp[i] = 1 + dp[i + 1];

            // Option 2: Find a length L such that s[i...i+L-1] == s[i+L...i+2L-1]
            // If such L exists, we can delete s[i...i+L-1] in one operation,
            // and then solve for the string starting from s[i+L...]
            // The condition i + 2 * L <= n ensures that s[i+L...i+2L-1] is within bounds.
            for (int len = 1; i + 2 * len <= n; len++) {
                // Check if s[i...i+len-1] is equal to s[i+len...i+2*len-1]
                // This is true if the longest common prefix of s[i...] and s[i+len...]
                // is at least 'len'.
                if (lcp[i][i + len] >= len) {
                    dp[i] = Math.max(dp[i], 1 + dp[i + len]);
                }
            }
        }

        return dp[0];
    }
}