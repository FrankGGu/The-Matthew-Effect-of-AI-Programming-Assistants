import java.util.Arrays;

class Solution {
    public int removeAlmostEqualCharacters(String s) {
        int n = s.length();
        if (n <= 1) {
            return 0;
        }

        // dp[i] stores the maximum length of a valid subsequence ending at index i.
        int[] dp = new int[n];
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = 1; // Base case: s.charAt(i) itself is a valid subsequence of length 1
            for (int j = 0; j < i; j++) {
                // If s.charAt(i) and s.charAt(j) are not almost-equal,
                // then s.charAt(i) can extend a valid subsequence ending at s.charAt(j).
                if (Math.abs(s.charAt(i) - s.charAt(j)) > 1) {
                    dp[i] = Math.max(dp[i], 1 + dp[j]);
                }
            }
            maxLen = Math.max(maxLen, dp[i]);
        }

        // The minimum number of removals is the total length of the string
        // minus the maximum length of a valid subsequence that can be formed.
        return n - maxLen;
    }
}