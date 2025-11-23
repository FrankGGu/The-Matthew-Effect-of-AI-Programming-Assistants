impl Solution {
    pub fn num_perms_di_sequence(s: String) -> i32 {
        let n = s.len();
        let modulo: i64 = 1_000_000_007;

        // dp[j] represents dp[i][j] where i is the current length-1 (0-indexed)
        // dp[i][j] is the number of permutations of [0, ..., i]
        // such that the last element (perm[i]) has rank j among [0, ..., i].
        // Initial state: i = 0 (permutation of [0]), perm[0] has rank 0.
        let mut dp = vec![1i64]; // dp[0] = 1

        for i in 0..n {
            let mut next_dp = vec![0i64; i + 2];
            let current_char = s.as_bytes()[i] as char;

            if current_char == 'I' {
                // 'I' means perm[i] < perm[i+1]
                // To compute next_dp[k] (perm[i+1] has rank k among [0...i+1]):
                // perm[i] must have had rank j < k among [0...i].
                // This is a prefix sum: sum(dp[j] for j in 0..k-1)
                let mut current_sum = 0i64;
                for k in 0..=i + 1 {
                    next_dp[k] = current_sum;
                    if k <= i { // dp[k] refers to dp[i][k]
                        current_sum = (current_sum + dp[k]) % modulo;
                    }
                }
            } else { // current_char == 'D'
                // 'D' means perm[i] > perm[i+1]
                // To compute next_dp[k] (perm[i+1] has rank k among [0...i+1]):
                // perm[i] must have had rank j >= k among [0...i].
                // This is a suffix sum: sum(dp[j] for j in k..i)
                let mut current_sum = 0i64;
                for k in (0..=i + 1).rev() {
                    if k <= i { // dp[k] refers to dp[i][k]
                        current_sum = (current_sum + dp[k]) % modulo;
                    }
                    next_dp[k] = current_sum;
                }
            }
            dp = next_dp;
        }

        // The final result is the sum of all elements in dp (which is dp[n])
        let mut total_permutations = 0i64;
        for val in dp {
            total_permutations = (total_permutations + val) % modulo;
        }

        total_permutations as i32
    }
}