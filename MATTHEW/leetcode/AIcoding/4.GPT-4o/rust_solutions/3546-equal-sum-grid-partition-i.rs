impl Solution {
    pub fn can_partition(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();
        let total_sum: i32 = grid.iter().flat_map(|x| x.iter()).sum();

        if total_sum % 2 != 0 {
            return false;
        }

        let target = total_sum / 2;
        let mut dp = vec![vec![false; (target + 1) as usize]; n + 1];
        dp[0][0] = true;

        for i in 0..n {
            for j in 0..m {
                let value = grid[i][j];
                for k in (0..=target).rev() {
                    for l in (0..=target).rev() {
                        if dp[i][k] || (k >= value && dp[i][k - value]) {
                            dp[i + 1][k] = true;
                        }
                        if dp[i][l] || (l >= value && dp[i][l - value]) {
                            dp[i + 1][l] = true;
                        }
                    }
                }
            }
        }

        dp[n][target]
    }
}