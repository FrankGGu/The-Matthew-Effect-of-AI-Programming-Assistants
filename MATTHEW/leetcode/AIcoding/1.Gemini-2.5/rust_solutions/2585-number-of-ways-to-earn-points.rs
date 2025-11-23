impl Solution {
    pub fn number_of_ways_to_earn_points(types: Vec<Vec<i32>>, target: i32) -> i32 {
        let modulo = 1_000_000_007;
        let target_usize = target as usize;
        let mut dp = vec![0; target_usize + 1];
        dp[0] = 1;

        for item_type in types {
            let count = item_type[0] as usize;
            let points = item_type[1] as usize;

            // Iterate backwards from target down to 0.
            // This ensures that when we update dp[next_points] using dp[p],
            // dp[p] represents the number of ways to achieve 'p' points
            // using only items from previous types, or from the current type
            // but for a sum of points less than 'p'.
            // This prevents overcounting by using items of the current type
            // multiple times within the same item type's loop iteration
            // when we are trying to add a specific number 'k' of them.
            for p in (0..=target_usize).rev() {
                if dp[p] == 0 {
                    continue; // If there's no way to get 'p' points, we can't extend from it.
                }

                // Try adding 1, 2, ..., 'count' items of the current type.
                for k in 1..=count {
                    let next_points = p + k * points;
                    if next_points <= target_usize {
                        dp[next_points] = (dp[next_points] + dp[p]) % modulo;
                    } else {
                        // If adding 'k' items exceeds the target,
                        // adding 'k+1' or more will also exceed it.
                        break;
                    }
                }
            }
        }

        dp[target_usize]
    }
}