class Solution {
    public int shortestCommonSupersequence(String str1, String str2) {
        int m = str1.length();
        int n = str2.length();
        int MOD = 1_000_000_007;

        // dp_len[i][j] stores the length of the shortest common supersequence of str1[0...i-1] and str2[0...j-1]
        int[][] dp_len = new int[m + 1][n + 1];
        // dp_count[i][j] stores the number of shortest common supersequences of str1[0...i-1] and str2[0...j-1]
        int[][] dp_count = new int[m + 1][n + 1];

        // Base cases for empty prefixes
        // SCS of str1[0...i-1] and empty string is str1[0...i-1]
        for (int i = 0; i <= m; i++) {
            dp_len[i][0] = i;
            dp_count[i][0] = 1; // There's only one way to form str1[0...i-1]
        }
        // SCS of empty string and str2[0...j-1] is str2[0...j-1]
        for (int j = 0; j <= n; j++) {
            dp_len[0][j] = j;
            dp_count[0][j] = 1; // There's only one way to form str2[0...j-1]
        }

        // dp_len[0][0] = 0, dp_count[0][0] = 1 (empty string is SCS of two empty strings)
        // These are correctly initialized by the loops.

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
                    // If characters match, we include this character once in the SCS.
                    // The length is 1 + SCS of the remaining prefixes.
                    dp_len[i][j] = 1 + dp_len[i - 1][j - 1];
                    // The count is simply the count of SCS of the remaining prefixes.
                    dp_count[i][j] = dp_count[i - 1][j - 1];
                } else {
                    // If characters don't match, we must include one of them to form an SCS.
                    // Option 1: Include str1.charAt(i-1). Then find SCS of str1[0...i-2] and str2[0...j-1].
                    // Length: 1 + dp_len[i-1][j]
                    // Option 2: Include str2.charAt(j-1). Then find SCS of str1[0...i-1] and str2[0...j-2].
                    // Length: 1 + dp_len[i][j-1]

                    if (dp_len[i - 1][j] < dp_len[i][j - 1]) {
                        // Option 1 yields a shorter SCS length.
                        dp_len[i][j] = 1 + dp_len[i - 1][j];
                        dp_count[i][j] = dp_count[i - 1][j];
                    } else if (dp_len[i][j - 1] < dp_len[i - 1][j]) {
                        // Option 2 yields a shorter SCS length.
                        dp_len[i][j] = 1 + dp_len[i][j - 1];
                        dp_count[i][j] = dp_count[i][j - 1];
                    } else {
                        // Both options yield the same shortest SCS length.
                        dp_len[i][j] = 1 + dp_len[i - 1][j]; // Could also use dp_len[i][j-1]
                        // Since str1.charAt(i-1) != str2.charAt(j-1), the supersequences formed by
                        // including str1.charAt(i-1) first are distinct from those formed by
                        // including str2.charAt(j-1) first. So, we sum their counts.
                        dp_count[i][j] = (dp_count[i - 1][j] + dp_count[i][j - 1]) % MOD;
                    }
                }
            }
        }

        return dp_count[m][n];
    }
}