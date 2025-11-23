use std::collections::HashSet;

impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<char>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        if (m + n - 1) % 2 != 0 {
            return false;
        }

        let mut dp: Vec<Vec<HashSet<i32>>> = vec![vec![HashSet::new(); n]; m];

        if grid[0][0] == '(' {
            dp[0][0].insert(1);
        } else {
            // If grid[0][0] is ')', it's impossible to start with a non-negative balance.
            // dp[0][0] remains empty, correctly indicating no valid path starts here.
        }

        for r in 0..m {
            for c in 0..n {
                if r == 0 && c == 0 {
                    continue;
                }

                let current_char = grid[r][c];
                let mut current_balances = HashSet::new();

                if r > 0 {
                    for &prev_balance in &dp[r - 1][c] {
                        if current_char == '(' {
                            current_balances.insert(prev_balance + 1);
                        } else {
                            if prev_balance - 1 >= 0 {
                                current_balances.insert(prev_balance - 1);
                            }
                        }
                    }
                }

                if c > 0 {
                    for &prev_balance in &dp[r][c - 1] {
                        if current_char == '(' {
                            current_balances.insert(prev_balance + 1);
                        } else {
                            if prev_balance - 1 >= 0 {
                                current_balances.insert(prev_balance - 1);
                            }
                        }
                    }
                }
                dp[r][c] = current_balances;
            }
        }

        dp[m - 1][n - 1].contains(&0)
    }
}