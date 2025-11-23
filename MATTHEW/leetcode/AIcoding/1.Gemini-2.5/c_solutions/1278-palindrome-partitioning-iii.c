#include <string.h>
#include <stdio.h> // Required for NULL, but not strictly for this problem. Included for general C practice.

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int palindromePartitionIII(char * s, int k){
    int n = strlen(s);

    // cost[i][j] stores the minimum changes to make s[i...j] a palindrome.
    // 'i' is the starting index, 'j' is the ending index (inclusive).
    int cost[n][n];

    // Initialize cost for single characters (length 1)
    for (int i = 0; i < n; ++i) {
        cost[i][i] = 0;
    }

    // Calculate cost for substrings of length 2 to n
    for (int len = 2; len <= n; ++len) {
        for (int i = 0; i <= n - len; ++i) {
            int j = i + len - 1; // End index of current substring s[i...j]
            if (s[i] == s[j]) {
                // If outer characters match, cost depends on the inner substring s[i+1...j-1]
                // For length 2, the inner substring is empty, so cost is 0.
                cost[i][j] = (len == 2) ? 0 : cost[i+1][j-1];
            } else {
                // If outer characters don't match, one change is needed, plus the cost of the inner substring
                // For length 2, one change is needed.
                cost[i][j] = (len == 2) ? 1 : cost[i+1][j-1] + 1;
            }
        }
    }

    // dp[i][j] stores the minimum changes to partition the prefix s[0...i-1] into j palindromic substrings.
    // 'i' represents the length of the prefix (or the end index + 1).
    // 'j' represents the number of partitions.
    int dp[n + 1][k + 1];

    // Initialize dp table with a large value representing infinity
    // Maximum possible changes for a string of length N is N/2 (e.g., "ababa..." -> "aaaaa...").
    // For N=100, max changes is 50. Since we sum costs, 50 * K (max 100) = 5000.
    // So, 5001 is a safe "infinity" value.
    const int INF = 5001; 
    for (int i = 0; i <= n; ++i) {
        for (int j = 0; j <= k; ++j) {
            dp[i][j] = INF;
        }
    }

    // Base case: 0 length string, 0 partitions, 0 changes
    dp[0][0] = 0;

    // Fill dp table
    // Iterate over the number of partitions (j)
    for (int j = 1; j <= k; ++j) {
        // Iterate over the length of the prefix (i)
        // A prefix of length 'i' must be at least 'j' characters long to be partitioned into 'j' parts.
        for (int i = 1; i <= n; ++i) { 
            // Iterate over possible split points (p) for the last partition
            // The current prefix is s[0...i-1].
            // The last (j-th) partition is s[p...i-1].
            // The previous j-1 partitions cover s[0...p-1].
            // 'p' is the length of the prefix for the first j-1 partitions.
            // So, 'p' must be at least 'j-1' (to accommodate j-1 partitions in s[0...p-1]).
            // 'p' must be less than 'i' (to ensure s[p...i-1] is a non-empty substring).
            for (int p = j - 1; p < i; ++p) {
                // If the previous state (dp[p][j-1]) is reachable (not INF)
                if (dp[p][j-1] != INF) {
                    // Update dp[i][j] with the minimum changes
                    // Current changes = changes for s[0...p-1] into j-1 parts + changes for s[p...i-1] to be a palindrome
                    dp[i][j] = MIN(dp[i][j], dp[p][j-1] + cost[p][i-1]);
                }
            }
        }
    }

    // The result is the minimum changes to partition the entire string s[0...n-1] into k parts
    return dp[n][k];
}