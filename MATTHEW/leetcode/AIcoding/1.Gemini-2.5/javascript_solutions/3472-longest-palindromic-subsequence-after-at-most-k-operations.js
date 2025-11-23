var longestPalindromicSubsequence = function(s, k) {
    const n = s.length;

    // dp[i][j][ops] stores the maximum length of a palindromic subsequence
    // for the substring s[i...j] using at most 'ops' operations.
    // Initialize all values to 0.
    const dp = Array(n).fill(0).map(() => 
                 Array(n).fill(0).map(() => 
                   Array(k + 1).fill(0)));

    // Base case: A single character is a palindrome of length 1.
    // This requires 0 operations. The available 'ops' budget doesn't change this.
    for (let i = 0; i < n; i++) {
        for (let ops = 0; ops <= k; ops++) {
            dp[i][i][ops] = 1;
        }
    }

    // Iterate over substring lengths (len) from 2 to n.
    for (let len = 2; len <= n; len++) {
        // Iterate over starting indices (i).
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1; // Calculate the corresponding ending index.

            // Iterate over the number of allowed operations (ops) from 0 to k.
            for (let ops = 0; ops <= k; ops++) {
                let currentMax = 0;

                // Option 1: Characters s[i] and s[j] are the same.
                // They can form the ends of a palindrome without using an operation.
                // The length is 2 (for s[i] and s[j]) plus the LPS of the inner substring s[i+1...j-1].
                if (s[i] === s[j]) {
                    // If len is 2, s[i+1...j-1] is an empty string, contributing 0 to the length.
                    currentMax = 2 + (len === 2 ? 0 : dp[i + 1][j - 1][ops]);
                }

                // Option 2: Characters s[i] and s[j] can be made to match by using one operation.
                // This is possible if there is at least one operation budget (ops > 0).
                // The length is 2 plus the LPS of the inner substring s[i+1...j-1]
                // with one less operation budget (ops - 1).
                if (ops > 0) {
                    // We take the maximum, as this option might be better than Option 1 even if s[i] === s[j]
                    // (e.g., if dp[i+1][j-1][ops-1] is much larger than dp[i+1][j-1][ops]).
                    currentMax = Math.max(currentMax, 2 + (len === 2 ? 0 : dp[i + 1][j - 1][ops - 1]));
                }

                // Option 3: s[i] is not included in the palindromic subsequence.
                // We consider the LPS of the substring s[i+1...j] with the same number of operations.
                currentMax = Math.max(currentMax, dp[i + 1][j][ops]);

                // Option 4: s[j] is not included in the palindromic subsequence.
                // We consider the LPS of the substring s[i...j-1] with the same number of operations.
                currentMax = Math.max(currentMax, dp[i][j - 1][ops]);

                // Store the maximum length found for s[i...j] with 'ops' operations.
                dp[i][j][ops] = currentMax;
            }
        }
    }

    // The final answer is the LPS of the entire string s[0...n-1] with 'k' operations.
    return dp[0][n - 1][k];
};