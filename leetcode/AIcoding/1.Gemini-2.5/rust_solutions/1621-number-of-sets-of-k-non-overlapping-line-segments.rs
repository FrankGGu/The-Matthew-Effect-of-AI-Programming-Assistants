impl Solution {
    pub fn number_of_sets(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let modulus = 1_000_000_007;

        // dp[i] will store the number of ways to choose 'current_k' segments
        // using 'i' points (0, ..., i-1).
        // The index 'i' goes from 0 to n.
        let mut dp = vec![0; n + 1];

        // Base case: For 0 segments (k=0), there is 1 way (choose nothing) for any number of points.
        // So, dp[i] = 1 for all i when k=0.
        for i in 0..=n {
            dp[i] = 1;
        }

        // Iterate for each number of segments from 1 to k
        for current_k in 1..=k {
            // prev_dp stores the results from (current_k - 1) segments
            let prev_dp = dp.clone();

            // current_sum accumulates sum_{p=0}^{i-2} dp[p][current_k-1]
            // This sum is used when point (i-1) is chosen as the right endpoint of a segment.
            let mut current_sum = 0;

            // For current_k segments, dp[0] should be 0 (cannot form segments from 0 points)
            dp[0] = 0;

            // Iterate for each number of points from 1 to n
            for i in 1..=n {
                // Case 1: Point (i-1) is NOT used as an endpoint of any segment.
                // The number of ways is dp[current_k][i-1], which is stored in dp[i-1] from the current row.
                dp[i] = dp[i-1];

                // Case 2: Point (i-1) IS used as the right endpoint of the current_k-th segment.
                // Let this segment be [x, i-1]. x can be from 0 to i-2.
                // The previous (current_k-1) segments must be chosen from points 0, ..., x-1.
                // The number of ways for this is dp[current_k-1][x].
                // We need to sum dp[current_k-1][x] for x from 0 to i-2.
                // This sum is accumulated in `current_sum`.
                dp[i] = (dp[i] + current_sum) % modulus;

                // Update current_sum for the next iteration (i+1).
                // For dp[current_k][i+1], we need sum up to dp[current_k-1][i-1].
                // So, we add dp[current_k-1][i-1] (which is prev_dp[i-1]) to current_sum.
                current_sum = (current_sum + prev_dp[i-1]) % modulus;
            }
        }

        // The result is dp[k][n], which is stored in dp[n] after the loops complete.
        dp[n] as i32
    }
}