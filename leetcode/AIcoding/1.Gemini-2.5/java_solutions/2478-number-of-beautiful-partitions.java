import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    private boolean isPrimeDigit(char c) {
        return c == '2' || c == '3' || c == '5' || c == '7';
    }

    public int beautifulPartitions(String s, int k, int minLength) {
        int n = s.length();

        // dp[i][j] represents the number of ways to partition s[0...i-1] into j beautiful partitions.
        // 'i' is the exclusive end index of the current prefix (length 'i').
        // 'j' is the number of partitions.
        long[][] dp = new long[n + 1][k + 1];

        // Base case: There is 1 way to partition an empty string (s[0...-1]) into 0 partitions.
        dp[0][0] = 1;

        // Iterate over the number of partitions from 1 to k
        for (int j = 1; j <= k; j++) {
            // currentSumOfPrevDp stores the sum of dp[x][j-1] for valid starting points 'x'
            // for the current (j-th) partition.
            // A starting point 'x' is valid if s.charAt(x) is a prime digit.
            // 'x' must also satisfy x <= i - minLength.
            long currentSumOfPrevDp = 0; 

            // Iterate over the exclusive end index 'i' of the current prefix s[0...i-1]
            // 'i' ranges from 1 to n (inclusive).
            for (int i = 1; i <= n; i++) {
                // If the current prefix length 'i' allows for a partition of at least minLength
                // ending at 'i-1', then 'i - minLength' is a potential starting index 'x' for this partition.
                // If s.charAt(i - minLength) is a prime digit, then dp[i - minLength][j - 1]
                // contributes to the ways to form 'j' partitions ending at 'i-1' or later.
                if (i - minLength >= 0 && isPrimeDigit(s.charAt(i - minLength))) {
                    currentSumOfPrevDp = (currentSumOfPrevDp + dp[i - minLength][j - 1]) % MOD;
                }

                // If the character at s.charAt(i-1) (the last character of the current prefix)
                // is a non-prime digit, then it can be the end of a beautiful partition.
                // In this case, the number of ways to form 'j' partitions ending at 'i-1'
                // is the accumulated sum of ways to form 'j-1' partitions ending at valid previous points.
                if (!isPrimeDigit(s.charAt(i - 1))) {
                    dp[i][j] = currentSumOfPrevDp;
                } else {
                    // If s.charAt(i-1) is a prime digit, it cannot be the end of a beautiful partition.
                    // So, there are 0 ways to form 'j' partitions ending at 'i-1'.
                    dp[i][j] = 0;
                }
            }
        }

        // The final answer is the number of ways to partition the entire string s (s[0...n-1])
        // into k beautiful partitions.
        return (int) dp[n][k];
    }
}