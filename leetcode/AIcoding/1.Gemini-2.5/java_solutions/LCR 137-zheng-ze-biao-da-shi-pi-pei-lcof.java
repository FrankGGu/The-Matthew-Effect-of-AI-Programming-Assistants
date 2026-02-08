class Solution {
    public boolean isMatch(String s, String p) {
        int m = s.length();
        int n = p.length();

        // dp[i][j] will be true if the first i characters of s match the first j characters of p.
        boolean[][] dp = new boolean[m + 1][n + 1];

        // Base case: An empty string matches an empty pattern.
        dp[0][0] = true;

        // Populate dp[0][j] for patterns like a*, a*b*, etc.
        // An empty string can match a pattern like "a*b*c*" if the '*' matches zero occurrences.
        for (int j = 1; j <= n; j++) {
            // If the current pattern character is '*', it can match zero of the preceding element.
            // So, p[0...j-1] (ending with '*') can match an empty string if p[0...j-3] also matches an empty string.
            if (p.charAt(j - 1) == '*') {
                dp[0][j] = dp[0][j - 2];
            }
        }

        // Fill the DP table for all s and p substrings
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                char currentSChar = s.charAt(i - 1);
                char currentPChar = p.charAt(j - 1);

                // Case 1: Current pattern character is '.' or matches current string character.
                // In this case, the match depends on the match of the preceding substrings.
                if (currentPChar == '.' || currentPChar == currentSChar) {
                    dp[i][j] = dp[i - 1][j - 1];
                } 
                // Case 2: Current pattern character is '*'.
                else if (currentPChar == '*') {
                    // '*' can match zero or more of the preceding element (p.charAt(j-2)).

                    // Option A: '*' matches zero occurrences of p.charAt(j-2).
                    // In this scenario, p[0...j-1] effectively becomes p[0...j-3].
                    // So, we check if s[0...i-1] matches p[0...j-3].
                    dp[i][j] = dp[i][j - 2];

                    // Option B: '*' matches one or more occurrences of p.charAt(j-2).
                    // This is possible if s.charAt(i-1) matches p.charAt(j-2) (or p.charAt(j-2) is '.').
                    // If it matches, then s[0...i-1] matches p[0...j-1] if s[0...i-2] matches p[0...j-1].
                    // (i.e., s[i-1] is consumed by p.charAt(j-2)*, and the rest s[0...i-2] matches p[0...j-1]).
                    char precedingPChar = p.charAt(j - 2);
                    if (precedingPChar == '.' || precedingPChar == currentSChar) {
                        dp[i][j] = dp[i][j] || dp[i - 1][j];
                    }
                }
                // Case 3: Current pattern character does not match current string character and is not '.' or '*'.
                // In this case, dp[i][j] remains false (its default initialized value).
            }
        }

        // The final result is whether the entire string s matches the entire pattern p.
        return dp[m][n];
    }
}