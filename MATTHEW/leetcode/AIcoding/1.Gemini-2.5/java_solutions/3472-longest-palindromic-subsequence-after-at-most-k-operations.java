class Solution {
    public int longestPalindromeSubsequence(String s, int k) {
        int n = s.length();

        // The maximum number of operations needed to make a subsequence of length L a palindrome
        // is L/2 (if all pairs of characters are different).
        // Since the maximum subsequence length is n, the maximum effective cost is n/2.
        // We cap the cost dimension at min(k, n/2) to optimize space and time.
        int maxCost = Math.min(k, n / 2);

        // dp[j][cost] will store the maximum length of a palindromic subsequence
        // for the substring s[i...j] using 'cost' operations.
        // We use a 2D array to represent the current 'i' row of the 3D DP table.
        int[][] dp = new int[n][maxCost + 1];

        // prev_dp[j][cost] will store the maximum length for s[i+1...j] using 'cost' operations.
        // This corresponds to the 'i+1' row of the 3D DP table.
        int[][] prev_dp = new int[n][maxCost + 1];

        // Base case: length 1 substrings (i == j)
        // A single character is a palindrome of length 1, costs 0 operations.
        // For i = n-1 (the last character), dp[n-1][n-1][cost] = 1.
        // In our space-optimized DP, this is dp[n-1][cost] for the 'i' loop iteration n-1.
        for (int cost = 0; cost <= maxCost; cost++) {
            dp[n - 1][cost] = 1;
        }

        // Iterate 'i' from n-2 down to 0
        for (int i = n - 2; i >= 0; i--) {
            // Swap dp and prev_dp.
            // The current 'dp' (which holds values for i+1) becomes 'prev_dp'.
            // A new 'dp' (or recycled 'prev_dp') is prepared for the current 'i'.
            int[][] temp = prev_dp;
            prev_dp = dp;
            dp = temp;

            // Reset dp for the current row 'i'.
            // This is important because dp[j][cost] for j < i should be 0 (or handled by base cases).
            // Also, dp[i][cost] needs to be set for the current i.
            for (int j = 0; j < n; j++) {
                for (int cost = 0; cost <= maxCost; cost++) {
                    dp[j][cost] = 0; 
                }
            }

            // Base case for current i: dp[i][i][cost] = 1.
            // A single character s[i] forms a palindrome of length 1 with 0 operations.
            for (int cost = 0; cost <= maxCost; cost++) {
                dp[i][cost] = 1;
            }

            // Iterate 'j' from i+1 up to n-1
            for (int j = i + 1; j < n; j++) {
                for (int cost = 0; cost <= maxCost; cost++) {
                    // Option 1: s[i] is not part of the palindromic subsequence's ends,
                    // or s[j] is not part of the palindromic subsequence's ends.
                    // This means we are considering subsequences from s[i+1...j] (prev_dp[j][cost])
                    // or s[i...j-1] (dp[j-1][cost]).
                    dp[j][cost] = Math.max(prev_dp[j][cost], dp[j - 1][cost]);

                    // Option 2: s[i] and s[j] are matched as ends of the palindromic subsequence.
                    // Calculate the operations needed to make s[i] and s[j] match.
                    int currentPairCost = (s.charAt(i) == s.charAt(j)) ? 0 : 1;

                    if (cost >= currentPairCost) {
                        int innerLength = 0;
                        // If there are characters between i and j (i.e., length > 2),
                        // we need the length of the palindromic subsequence for s[i+1...j-1].
                        // This corresponds to prev_dp[j-1][cost - currentPairCost].
                        if (i + 1 <= j - 1) { 
                            innerLength = prev_dp[j - 1][cost - currentPairCost];
                        }
                        // If length is 2 (j = i+1), then i+1 > j-1, so innerLength remains 0.
                        // In this case, 2 + 0 = 2, which is correct for a two-character palindrome.
                        dp[j][cost] = Math.max(dp[j][cost], 2 + innerLength);
                    }
                }
            }
        }

        // The final answer is the maximum length for the entire string s[0...n-1]
        // using at most 'maxCost' operations.
        return dp[n - 1][maxCost];
    }
}