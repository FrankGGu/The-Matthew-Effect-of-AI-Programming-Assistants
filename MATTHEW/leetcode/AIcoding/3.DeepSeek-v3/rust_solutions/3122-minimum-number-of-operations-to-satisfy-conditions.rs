impl Solution {
    pub fn minimum_operations(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut freq = vec![vec![0; 10]; n];

        for i in 0..m {
            for j in 0..n {
                freq[j][grid[i][j] as usize] += 1;
            }
        }

        let mut dp = vec![vec![i32::MAX; 10]; n];
        for k in 0..10 {
            dp[0][k] = m as i32 - freq[0][k];
        }

        for j in 1..n {
            for k in 0..10 {
                for prev_k in 0..10 {
                    if prev_k != k {
                        dp[j][k] = dp[j][k].min(dp[j - 1][prev_k] + m as i32 - freq[j][k]);
                    }
                }
            }
        }

        *dp[n - 1].iter().min().unwrap()
    }
}