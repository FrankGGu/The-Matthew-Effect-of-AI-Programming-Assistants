impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_rotate_steps(ring: String, key: String) -> i32 {
        let n = ring.len();
        let mut pos_map = std::collections::HashMap::new();
        for (i, c) in ring.chars().enumerate() {
            pos_map.entry(c).or_insert(Vec::new()).push(i);
        }

        let mut dp = vec![0; n];
        for (i, c) in key.chars().enumerate() {
            let mut next_dp = vec![i32::MAX; n];
            for &pos in pos_map.get(&c).unwrap() {
                for j in 0..n {
                    if dp[j] == i32::MAX {
                        continue;
                    }
                    let steps = (n - (j as i32 - pos as i32).abs()).min((j as i32 - pos as i32).abs()) + 1;
                    next_dp[pos] = next_dp[pos].min(dp[j] + steps);
                }
            }
            dp = next_dp;
        }

        *dp.iter().min().unwrap()
    }
}
}