import java.util.Arrays;

class Solution {
    public int minimumChanges(String s, int k) {
        int n = s.length();

        // Precompute the minimum changes to make any substring s[i...j] a semi-palindrome
        // semiPalindromeCost[i][j] stores the minimum changes for substring s[i...j]
        int[][] semiPalindromeCost = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int currentChanges = 0;
                int len = j - i + 1;
                // Iterate for indices from 0 to len/2 - 1
                for (int idx = 0; idx < len / 2; idx++) {
                    char charLeft = s.charAt(i + idx);
                    char charRight = s.charAt(j - idx); // Character symmetric to charLeft

                    boolean match1 = (charLeft == charRight);
                    boolean match2 = false;

                    // Check for the alternative match: charLeft vs character one position to the left of charRight
                    // This alternative character is s[j - idx - 1]
                    // Ensure that s[j - idx - 1] is a valid index and is not to the left of s[i + idx]
                    if (j - idx - 1 >= i + idx) { 
                        char charRightMinus1 = s.charAt(j - idx - 1);
                        match2 = (charLeft == charRightMinus1);
                    }

                    // If neither of the conditions is met, one change is required for this pair
                    if (!match1 && !match2) {
                        currentChanges++;
                    }
                }
                semiPalindromeCost[i][j] = currentChanges;
            }
        }

        // dp[j][i] = minimum changes to form 'j' semi-palindromes using the first 'i' characters (s[0...i-1])
        int[][] dp = new int[k + 1][n + 1];

        // Initialize dp table with a large value to represent infinity
        // Using Integer.MAX_VALUE / 2 to prevent overflow when adding costs
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE / 2);
        }

        // Base case: 0 semi-palindromes using 0 characters requires 0 changes
        dp[0][0] = 0;

        // Iterate over the number of semi-palindromes we want to form (from 1 to k)
        for (int j = 1; j <= k; j++) {
            // Iterate over the current prefix length (from 1 to n)
            for (int i = 1; i <= n; i++) {
                // Iterate over all possible split points 'p' for the last semi-palindrome
                // The last semi-palindrome is s[p...i-1]
                // 'p' represents the start index of the last semi-palindrome, and also the length of the prefix for (j-1) semi-palindromes
                for (int p = 0; p < i; p++) {
                    // If it's possible to form (j-1) semi-palindromes using the first 'p' characters
                    if (dp[j - 1][p] != Integer.MAX_VALUE / 2) {
                        int costForLastSegment = semiPalindromeCost[p][i - 1];
                        dp[j][i] = Math.min(dp[j][i], dp[j - 1][p] + costForLastSegment);
                    }
                }
            }
        }

        // The result is the minimum changes to form 'k' semi-palindromes using all 'n' characters
        return dp[k][n];
    }
}