import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minExtraChar(String s, String[] dictionary) {
        int n = s.length();
        Set<String> wordSet = new HashSet<>(Arrays.asList(dictionary));

        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            // Option 1: The current character s[i-1] is an extra character.
            // So, dp[i] is at least dp[i-1] + 1.
            dp[i] = dp[i-1] + 1; 

            // Option 2: Try to form a word ending at s[i-1].
            // Iterate through all possible starting points j for a word ending at i-1.
            for (int j = 0; j < i; j++) {
                String sub = s.substring(j, i);
                if (wordSet.contains(sub)) {
                    // If s[j...i-1] is a valid word, then the extra characters for s[0...i-1]
                    // could be the extra characters for s[0...j-1] (dp[j]) plus 0 for the current word.
                    dp[i] = Math.min(dp[i], dp[j]);
                }
            }
        }

        return dp[n];
    }
}