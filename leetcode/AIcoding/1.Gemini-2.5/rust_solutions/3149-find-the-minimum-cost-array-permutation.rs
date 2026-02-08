impl Solution {
    pub fn find_minimum_cost_array_permutation(cost: Vec<Vec<i32>>) -> i32 {
        let n = cost.len();
        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 1..(1 << n) {
            let current_pos = mask.count_ones() as usize - 1; 

            for j in 0..n {
                if (mask >> j) & 1 == 1 { 
                    let prev_mask = mask ^ (1 << j); 
                    if dp[prev_mask] != std::i32::MAX {
                        dp[mask] = dp[mask].min(dp[prev_mask] + cost[current_pos][j]);
                    }
                }
            }
        }

        dp[(1 << n) - 1]
    }
}