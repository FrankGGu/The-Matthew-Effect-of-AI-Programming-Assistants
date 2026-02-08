impl Solution {
    pub fn can_partition(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();
        let total_sum: i32 = grid.iter().flat_map(|x| x.iter()).sum();

        if total_sum % 2 != 0 {
            return false;
        }

        let target = total_sum / 2;
        let mut dp = vec![false; (target + 1) as usize];
        dp[0] = true;

        for r in 0..n {
            for c in 0..m {
                let num = grid[r][c];
                for j in (num..=target).rev() {
                    dp[j as usize] |= dp[(j - num) as usize];
                }
            }
        }

        dp[target as usize]
    }
}