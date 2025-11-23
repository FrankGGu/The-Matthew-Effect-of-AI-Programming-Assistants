impl Solution {
    pub fn build_array(n: i32, m: i32, k: i32) -> i32 {
        let n = n as usize;
        let m = m as usize;
        let k = k as usize;
        let modulo = 1_000_000_007;

        // dp[i][j][p] = number of ways to build an array of length `i`,
        // where the maximum element is `j`, and `p` search costs have been incurred.
        // i: array length (0 to n)
        // j: maximum element value (0 to m)
        // p: number of comparisons (0 to k)
        let mut dp = vec![vec![vec![0; k + 1]; m + 1]; n + 1];

        // Base case: For an array of length 1, the maximum element is the element itself,
        // and it costs 1 comparison.
        // dp[1][j][1] = 1 for j from 1 to m.
        for j_val in 1..=m {
            dp[1][j_val][1] = 1;
        }

        // Fill the DP table for lengths from 1 up to n-1
        for i_len in 1..n { // 'i_len' is the current length of the array being considered (from 1 to n-1)
            for j_max_val in 1..=m { // 'j_max_val' is the current maximum value in the array (from 1 to m)
                for p_comps in 1..=k { // 'p_comps' is the current number of comparisons (from 1 to k)
                    // If there are no ways to form the array of length `i_len` with max `j_max_val` and `p_comps`, skip.
                    if dp[i_len][j_max_val][p_comps] == 0 {
                        continue;
                    }

                    // Option 1: Append a new element `x` (1 <= x <= j_max_val) to the array.
                    // The maximum remains `j_max_val`. The number of comparisons remains `p_comps`.
                    // There are `j_max_val` choices for `x`.
                    // Add `dp[i_len][j_max_val][p_comps] * j_max_val` to `dp[i_len + 1][j_max_val][p_comps]`.
                    let ways_same_max = (dp[i_len][j_max_val][p_comps] as i64 * j_max_val as i64) % modulo;
                    dp[i_len + 1][j_max_val][p_comps] = (dp[i_len + 1][j_max_val][p_comps] + ways_same_max) as i32;

                    // Option 2: Append a new element `next_max_val` (j_max_val < next_max_val <= m) to the array.
                    // `next_max_val` becomes the new maximum. The number of comparisons becomes `p_comps + 1`.
                    // This is only possible if `p_comps` is less than `k`.
                    if p_comps < k {
                        for next_max_val in (j_max_val + 1)..=m {
                            // Add `dp[i_len][j_max_val][p_comps]` to `dp[i_len + 1][next_max_val][p_comps + 1]`.
                            dp[i_len + 1][next_max_val][p_comps + 1] =
                                (dp[i_len + 1][next_max_val][p_comps + 1] + dp[i_len][j_max_val][p_comps]) % modulo;
                        }
                    }
                }
            }
        }

        // The final answer is the sum of all ways to build an array of length `n`
        // with exactly `k` comparisons, for any possible maximum element `j_max_val` from 1 to m.
        let mut total_ways = 0;
        for j_max_val in 1..=m {
            total_ways = (total_ways + dp[n][j_max_val][k]) % modulo;
        }

        total_ways
    }
}