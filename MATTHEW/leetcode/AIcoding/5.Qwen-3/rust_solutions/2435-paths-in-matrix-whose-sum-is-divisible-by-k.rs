impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_paths(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![HashMap::new(); n]; m];
        let mod_k = k as i32;

        for i in 0..m {
            for j in 0..n {
                let current_sum = if i == 0 && j == 0 {
                    grid[i][j]
                } else if i == 0 {
                    dp[i][j - 1].keys().map(|&k| (k + grid[i][j]) % mod_k).collect::<Vec<_>>()
                } else if j == 0 {
                    dp[i - 1][j].keys().map(|&k| (k + grid[i][j]) % mod_k).collect::<Vec<_>>()
                } else {
                    let mut temp = dp[i - 1][j].keys().map(|&k| (k + grid[i][j]) % mod_k).collect::<Vec<_>>();
                    temp.extend(dp[i][j - 1].keys().map(|&k| (k + grid[i][j]) % mod_k));
                    temp
                };

                let mut count_map = HashMap::new();
                for val in current_sum {
                    *count_map.entry(val).or_insert(0) += 1;
                }

                if i == 0 && j == 0 {
                    count_map.insert(grid[i][j] % mod_k, 1);
                }

                dp[i][j] = count_map;
            }
        }

        let last_row = &dp[m - 1][n - 1];
        *last_row.get(&0).unwrap_or(&0)
    }
}
}