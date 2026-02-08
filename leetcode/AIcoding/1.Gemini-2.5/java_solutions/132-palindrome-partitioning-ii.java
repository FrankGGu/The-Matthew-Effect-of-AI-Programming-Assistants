class Solution {
    public int minCut(String s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        // isPalindrome[j][i] will be true if s[j...i] is a palindrome
        boolean[][] isPalindrome = new boolean[n][n];

        // dp[i] will store the minimum cuts needed for the prefix s[0...i-1]
        // dp array size n+1, dp[0] is a base case for empty string
        int[] dp = new int[n + 1];

        // Precompute isPalindrome table
        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                if (s.charAt(j) == s.charAt(i) && (i - j <= 1 || isPalindrome[j + 1][i - 1])) {
                    isPalindrome[j][i] = true;
                }
            }
        }

        // Initialize dp array
        // dp[0] = -1 is a sentinel value.
        // If s[0...i-1] is a palindrome, dp[i] = dp[0] + 1 = 0 cuts.
        dp[0] = -1; 
        for (int i = 1; i <= n; i++) {
            // Worst case: cut after every character, e.g., "a|b|c" needs 2 cuts for length 3.
            // For s[0...i-1] (length i), worst case is i-1 cuts.
            dp[i] = i - 1; 
        }

        // Fill dp array
        for (int i = 1; i <= n; i++) { // i represents the length of the prefix s[0...i-1]
            for (int j = 0; j < i; j++) { // j is the starting index of the last palindrome s[j...i-1]
                if (isPalindrome[j][i - 1]) {
                    // If s[j...i-1] is a palindrome, we can make a cut before j
                    // The number of cuts would be dp[j] (cuts for s[0...j-1]) + 1 (for the current cut)
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n];
    }
}