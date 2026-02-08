class Solution {
    public int numDistinct(String s, String t) {
        int m = s.length();
        int n = t.length();

        // dp[i][j] will be the number of distinct subsequences of s[0...i-1] which equals t[0...j-1]
        // The problem statement guarantees the answer fits in a 32-bit signed integer,
        // implying that intermediate sums will also fit.
        int[][] dp = new int[m + 1][n + 1];

        // Base case: An empty string t (j=0) can always be formed in 1 way
        // (by deleting all characters from s).
        for (int i = 0; i <= m; i++) {
            dp[i][0] = 1;
        }

        // Fill the DP table
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                // If the characters s.charAt(i-1) and t.charAt(j-1) match:
                // We have two options:
                // 1. Use s.charAt(i-1) to match t.charAt(j-1). In this case, we need to find
                //    the number of distinct subsequences of s[0...i-2] that equal t[0...j-2].
                //    This count is dp[i-1][j-1].
                // 2. Do not use s.charAt(i-1) (effectively deleting it). In this case, we need to find
                //    the number of distinct subsequences of s[0...i-2] that equal t[0...j-1].
                //    This count is dp[i-1][j].
                // The total ways are the sum of these two options.
                if (s.charAt(i - 1) == t.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j] + dp[i - 1][j - 1];
                } else {
                    // If the characters s.charAt(i-1) and t.charAt(j-1) do not match:
                    // We cannot use s.charAt(i-1) to match t.charAt(j-1).
                    // Therefore, s.charAt(i-1) must be deleted.
                    // The number of ways is the same as finding subsequences of s[0...i-2]
                    // that equal t[0...j-1]. This count is dp[i-1][j].
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }

        // The final answer is the number of distinct subsequences of s (full string)
        // that equal t (full string).
        return dp[m][n];
    }
}