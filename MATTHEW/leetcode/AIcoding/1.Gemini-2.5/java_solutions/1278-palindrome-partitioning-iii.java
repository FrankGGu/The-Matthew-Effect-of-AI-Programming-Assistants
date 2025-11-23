import java.util.Arrays;

class Solution {
    public int palindromePartition(String s, int k) {
        int n = s.length();

        // Precompute the cost to make any substring s[i...j] a palindrome
        // cost[i][j] stores the minimum changes to make s.substring(i, j+1) a palindrome
        int[][] cost = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int changes = 0;
                int left = i;
                int right = j;
                while (left < right) {
                    if (s.charAt(left) != s.charAt(right)) {
                        changes++;
                    }
                    left++;
                    right--;
                }
                cost[i][j] = changes;
            }
        }

        // dp[i][j] stores the minimum changes to partition s[0...i-1] into j palindromic substrings
        // i represents the length of the prefix s[0...i-1]
        // j represents the number of partitions
        int[][] dp = new int[n + 1][k + 1];

        // Initialize dp table with a large value (infinity)
        // Use Integer.MAX_VALUE / 2 to prevent overflow when adding costs
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }

        // Base case: 0 length string, 0 partitions, 0 cost
        dp[0][0] = 0;

        // Fill the dp table
        for (int j = 1; j <= k; j++) { // Iterate over number of partitions (from 1 to k)
            for (int i = 1; i <= n; i++) { // Iterate over prefix length (from 1 to n)
                // If current prefix length 'i' is less than number of partitions 'j',
                // it's impossible to partition, so dp[i][j] remains infinity.
                if (i < j) {
                    continue;
                }

                // Iterate over all possible split points 'p' for the j-th partition
                // 'p' represents the end index (exclusive) of the (j-1)-th partition
                // s[0...p-1] is partitioned into j-1 parts
                // s[p...i-1] is the j-th partition
                // 'p' must be at least j-1 (to have j-1 characters for j-1 partitions)
                // 'p' must be at most i-1 (to leave at least 1 character for the j-th partition)
                for (int p = j - 1; p < i; p++) {
                    if (dp[p][j - 1] != Integer.MAX_VALUE / 2) { // Check if previous state is reachable
                        dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + cost[p][i - 1]);
                    }
                }
            }
        }

        // The result is the minimum changes to partition s[0...n-1] into k partitions
        return dp[n][k];
    }
}