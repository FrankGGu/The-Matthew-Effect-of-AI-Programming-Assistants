impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<char>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![std::collections::HashSet::new(); n]; m];

        if grid[0][0] == '(' {
            dp[0][0].insert(1);
        } else {
            return false;
        }

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    continue;
                }
                let mut current = std::collections::HashSet::new();
                if i > 0 {
                    for &val in &dp[i-1][j] {
                        current.insert(val);
                    }
                }
                if j > 0 {
                    for &val in &dp[i][j-1] {
                        current.insert(val);
                    }
                }
                let mut next = std::collections::HashSet::new();
                for val in current {
                    if grid[i][j] == '(' {
                        next.insert(val + 1);
                    } else if val > 0 {
                        next.insert(val - 1);
                    }
                }
                dp[i][j] = next;
            }
        }

        dp[m-1][n-1].contains(&0)
    }
}