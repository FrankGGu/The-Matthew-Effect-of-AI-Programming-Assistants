impl Solution {
    pub fn get_happiness(m: i32, n: i32, introverts_count: i32, extroverts_count: i32) -> i32 {
        let mut dp = vec![vec![vec![vec![0; extroverts_count as usize + 1]; introverts_count as usize + 1]; n as usize + 1]; m as usize + 1];

        for i in 0..=m {
            for j in 0..=n {
                for k in 0..=introverts_count {
                    for l in 0..=extroverts_count {
                        if i == m && j == n {
                            continue;
                        }
                        let new_i = if j + 1 < n { i } else { i + 1 };
                        let new_j = if j + 1 < n { j + 1 } else { 0 };

                        // Place an introvert
                        if k + 1 <= introverts_count {
                            dp[new_i][new_j][k + 1][l] = dp[new_i][new_j][k + 1][l].max(dp[i][j][k][l] + 120);
                        }
                        // Place an extrovert
                        if l + 1 <= extroverts_count {
                            dp[new_i][new_j][k][l + 1] = dp[new_i][new_j][k][l + 1].max(dp[i][j][k][l] + 40);
                        }
                        // Place nothing
                        dp[new_i][new_j][k][l] = dp[new_i][new_j][k][l].max(dp[i][j][k][l]);

                        // Calculate happiness for current placements
                        if k > 0 {
                            dp[new_i][new_j][k][l] = dp[new_i][new_j][k][l].max(dp[i][j][k][l] + 40);
                        }
                        if l > 0 {
                            dp[new_i][new_j][k][l] = dp[new_i][new_j][k][l].max(dp[i][j][k][l] + 120);
                        }
                    }
                }
            }
        }

        let mut max_happiness = 0;
        for k in 0..=introverts_count {
            for l in 0..=extroverts_count {
                max_happiness = max_happiness.max(dp[m as usize][n as usize][k as usize][l as usize]);
            }
        }
        max_happiness
    }
}