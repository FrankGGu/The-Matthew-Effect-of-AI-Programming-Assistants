use std::cmp::min;

const INF: i32 = i32::MAX / 2; // Use a large enough value to represent infinity

impl Solution {
    pub fn merge_stones(stones: Vec<i32>, k: i32) -> i32 {
        let n = stones.len();
        let k_usize = k as usize;

        if n == 0 {
            return 0;
        }

        // If it's impossible to merge all stones into one pile.
        // Each merge operation reduces the number of piles by (k - 1).
        // To go from n piles to 1 pile, we need (n - 1) merges.
        // So, (n - 1) must be divisible by (k - 1).
        // If n == 1, (1 - 1) % (k - 1) = 0 % (k - 1) = 0, which is correct (cost is 0).
        if (n - 1) % (k_usize - 1) != 0 {
            return -1;
        }

        // Precompute prefix sums for efficient sum calculation
        // prefix_sum[x] stores the sum of stones[0]...stones[x-1]
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + stones[i];
        }

        // dp[i][j][p] = minimum cost to merge stones[i..j] into p piles
        // Dimensions: n x n x (k_usize + 1)
        let mut dp = vec![vec![vec![INF; k_usize + 1]; n]; n];

        // Base case: merging a single stone into 1 pile costs 0
        for i in 0..n {
            dp[i][i][1] = 0;
        }

        // Iterate over subarray lengths
        for len in 2..=n {
            // Iterate over starting indices
            for i in 0..=n - len {
                let j = i + len - 1; // Ending index

                // Calculate dp[i][j][p] for p from 2 to k_usize
                // These are intermediate merges to form p piles
                for p in 2..=k_usize {
                    // Check if it's possible to form p piles from stones[i..j]
                    // 1. The number of piles 'p' must be less than or equal to the number of stones 'len'.
                    // 2. The reduction in piles (len - p) must be a multiple of (k_usize - 1).
                    // This is because each merge operation reduces the number of piles by (k_usize - 1).
                    if len < p || (len - p) % (k_usize - 1) != 0 {
                        continue; // dp[i][j][p] remains INF
                    }

                    // Iterate over all possible split points 'mid'
                    // We split stones[i..j] into two segments: [i..mid] and [mid+1..j].
                    // We merge stones[i..mid] into 1 pile (cost dp[i][mid][1]).
                    // We merge stones[mid+1..j] into p-1 piles (cost dp[mid+1][j][p-1]).
                    // The sum of these costs gives the cost to form 'p' piles from [i..j].
                    for mid in i..j {
                        if dp[i][mid][1] != INF && dp[mid + 1][j][p - 1] != INF {
                            dp[i][j][p] = min(dp[i][j][p], dp[i][mid][1] + dp[mid + 1][j][p - 1]);
                        }
                    }
                }

                // Calculate dp[i][j][1] (minimum cost to merge stones[i..j] into 1 pile)
                // This is only possible if we first merge them into 'k_usize' piles,
                // and then perform the final merge operation.
                // This requires:
                // 1. The length of the segment 'len' must be at least 'k_usize'.
                // 2. The total reduction in piles (len - 1) must be a multiple of (k_usize - 1).
                if len >= k_usize && (len - 1) % (k_usize - 1) == 0 {
                    if dp[i][j][k_usize] != INF {
                        // The cost of the final merge is the sum of all stones in the range [i, j]
                        let current_sum = prefix_sum[j + 1] - prefix_sum[i];
                        dp[i][j][1] = dp[i][j][k_usize] + current_sum;
                    }
                }
            }
        }

        // The final answer is the minimum cost to merge all stones (0..n-1) into 1 pile
        if dp[0][n - 1][1] == INF {
            -1
        } else {
            dp[0][n - 1][1]
        }
    }
}