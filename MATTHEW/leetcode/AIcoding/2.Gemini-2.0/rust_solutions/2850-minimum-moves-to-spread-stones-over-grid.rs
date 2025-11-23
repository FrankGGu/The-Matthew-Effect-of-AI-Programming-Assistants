impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let mut zeros = Vec::new();
        let mut stones = Vec::new();

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 0 {
                    zeros.push((i as i32, j as i32));
                } else if grid[i][j] > 1 {
                    for _ in 1..grid[i][j] {
                        stones.push((i as i32, j as i32));
                    }
                }
            }
        }

        let n = zeros.len();
        let mut dp = vec![vec![i32::MAX; 1 << n]; n + 1];
        dp[0][0] = 0;

        for i in 0..n {
            for mask in 0..(1 << n) {
                if dp[i][mask] == i32::MAX {
                    continue;
                }
                for j in 0..n {
                    if (mask & (1 << j)) == 0 {
                        let cost = (zeros[j].0 - stones[i].0).abs() + (zeros[j].1 - stones[i].1).abs();
                        dp[i + 1][mask | (1 << j)] = dp[i + 1][mask | (1 << j)].min(dp[i][mask] + cost);
                    }
                }
            }
        }

        dp[n][(1 << n) - 1]
    }
}