var maxDeletions = function(s) {
    const n = s.length;
    if (n === 0) {
        return 0;
    }

    // lcp[i][j] stores the length of the longest common prefix of s[i...] and s[j...]
    // This table is computed using dynamic programming.
    // lcp[i][j] = 1 + lcp[i+1][j+1] if s[i] === s[j]
    // lcp[i][j] = 0 if s[i] !== s[j]
    // Base cases: lcp[n][j] = 0, lcp[i][n] = 0
    const lcp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (s[i] === s[j]) {
                lcp[i][j] = 1 + lcp[i + 1][j + 1];
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    // dp[i] stores the maximum number of deletions for the suffix s[i...]
    const dp = Array(n + 1).fill(0);
    // dp[n] is 0 (empty string, no deletions possible)

    for (let i = n - 1; i >= 0; i--) {
        // Option 1: Delete the character s[i] alone.
        // This counts as 1 deletion.
        // The problem then reduces to finding maximum deletions for the suffix s[i+1...].
        let res = 1 + dp[i + 1];

        // Option 2: Perform the special operation.
        // Choose a length 'len' such that s[i...i+len-1] is equal to s[i+len...i+2*len-1].
        // This counts as 1 deletion.
        // The problem then reduces to finding maximum deletions for the suffix s[i+len...].
        // The second substring s[i+len...i+2*len-1] must be entirely within bounds.
        // So, i + 2 * len must be <= n.
        for (let len = 1; i + 2 * len <= n; len++) {
            const j = i + len; // This is the starting index of the second substring
            if (lcp[i][j] >= len) { // Check if s[i...i+len-1] == s[j...j+len-1]
                res = Math.max(res, 1 + dp[j]);
            }
        }
        dp[i] = res;
    }

    return dp[0];
};