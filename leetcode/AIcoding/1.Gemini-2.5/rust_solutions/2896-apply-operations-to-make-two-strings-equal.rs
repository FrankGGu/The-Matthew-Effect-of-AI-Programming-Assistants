struct Solution;

impl Solution {
    pub fn min_operations(s1: String, s2: String, x: i32) -> i32 {
        let n = s1.len();
        let s1_bytes = s1.as_bytes();

        let mut diff_indices = Vec::new();
        for i in 0..n {
            if s1_bytes[i] != s2.as_bytes()[i] {
                diff_indices.push(i);
            }
        }

        let m = diff_indices.len();

        if m == 0 {
            return 0;
        }

        if m % 2 != 0 {
            return -1;
        }

        // dp[i] will store the minimum cost to fix the first 'i' mismatches.
        // The indices in diff_indices are 0-indexed, so diff_indices[k] is the (k+1)-th mismatch.
        // dp[i] corresponds to fixing mismatches from diff_indices[0] to diff_indices[i-1].
        let mut dp = vec![0; m + 1];

        // dp[0] is 0 (cost to fix 0 mismatches)

        // Loop from 1 to m to calculate dp[i]
        for i in 1..=m {
            // Option 1: Fix the i-th mismatch (diff_indices[i-1]) by flipping.
            // Cost is dp[i-1] (cost to fix first i-1 mismatches) + 1 (for the current flip).
            dp[i] = dp[i-1] + 1;

            // Option 2: If we have at least two mismatches (i >= 2),
            // consider fixing the i-th and (i-1)-th mismatches by a swap.
            if i >= 2 {
                let idx_current = diff_indices[i-1];
                let idx_prev = diff_indices[i-2];

                // A swap operation s1[k] and s1[j] is valid only if s1[k] != s1[j].
                // If s1[k] != s2[k] and s1[j] != s2[j] and s1[k] != s1[j],
                // then swapping s1[k] and s1[j] will fix both mismatches.
                // (e.g., if s1[k]='0', s2[k]='1', s1[j]='1', s2[j]='0', then swap makes s1[k]='1', s1[j]='0')
                if s1_bytes[idx_current] != s1_bytes[idx_prev] {
                    // Cost is dp[i-2] (cost to fix first i-2 mismatches) + x (for the swap).
                    dp[i] = dp[i].min(dp[i-2] + x);
                }
            }
        }

        dp[m]
    }
}