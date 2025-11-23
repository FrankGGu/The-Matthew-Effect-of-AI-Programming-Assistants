impl Solution {
    pub fn max_deletions(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_bytes = s.as_bytes();

        // lcp[i][j] stores the length of the longest common prefix of s[i..] and s[j..]
        // The table size is (n+1) x (n+1) to handle indices up to n.
        let mut lcp = vec![vec![0; n + 1]; n + 1];

        // Fill LCP table using dynamic programming.
        // Iterate from n-1 down to 0 for both i and j.
        // This ensures lcp[i+1][j+1] is already computed when needed.
        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if s_bytes[i] == s_bytes[j] {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        // dp[i] stores the maximum number of deletions we can perform on the suffix s[i..]
        // The table size is (n+1) to handle index n.
        let mut dp = vec![0; n + 1];

        // Base case: dp[n] = 0 (empty string, 0 deletions) - already initialized to 0.

        // Iterate from n-1 down to 0 to fill the dp table.
        // dp[i] depends on dp[k] where k > i.
        for i in (0..n).rev() {
            // Option 1: If the current string s[i..] is not empty, we can always perform at least one deletion.
            // This represents deleting the entire remaining string s[i..] as a single operation,
            // or performing a deletion that leaves a string that cannot be further processed.
            dp[i] = 1;

            // Option 2: Try to find a split point to perform a deletion according to the rules.
            // A deletion involves a prefix s[i...i+len-1] and a matching segment s[i+len...i+2*len-1].
            // The length of the prefix (and the matching segment) is `len`.
            // The total length consumed by this operation is `2*len`.
            // The remaining string after this deletion starts at `i + 2*len`.
            for len in 1.. {
                // Check if the two segments fit within the current string s[i..].
                // `i + 2 * len` must be less than or equal to `n`.
                if i + 2 * len > n {
                    break; // No more valid `len` values for this `i`
                }

                // Check if s[i...i+len-1] is equal to s[i+len...i+2*len-1].
                // This is efficiently checked by comparing `lcp[i][i + len]` with `len`.
                // If `lcp[i][i + len]` is greater than or equal to `len`, it means the prefixes of length `len` are identical.
                if lcp[i][i + len] >= len {
                    // If they are equal, we can perform this deletion.
                    // This counts as 1 deletion, plus the maximum deletions possible from the remaining string s[i+2*len..].
                    dp[i] = dp[i].max(1 + dp[i + 2 * len]);
                }
            }
        }

        // The result is the maximum deletions from the original string s[0..].
        dp[0]
    }
}