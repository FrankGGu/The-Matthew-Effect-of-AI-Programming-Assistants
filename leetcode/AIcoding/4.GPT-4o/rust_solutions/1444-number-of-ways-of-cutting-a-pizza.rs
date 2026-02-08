impl Solution {
    pub fn ways_to_cut_pizza(pizza: Vec<String>, k: i32) -> i32 {
        let m = pizza.len();
        let n = pizza[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                prefix[i][j] = match pizza[i].chars().nth(j).unwrap() {
                    'A' => 1,
                    _ => 0,
                } + prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1];
            }
        }

        let mut dp = vec![vec![vec![0; k as usize]; n]; m];

        for i in 0..m {
            for j in 0..n {
                dp[i][j][0] = 1;
            }
        }

        for cuts in 1..k {
            for i in 0..m {
                for j in 0..n {
                    for x in i + 1..m {
                        if prefix[i][j] - prefix[x][j] > 0 {
                            dp[i][j][cuts as usize] = (dp[i][j][cuts as usize] + dp[x][j][cuts as usize]) % 1_000_000_007;
                        }
                    }
                    for y in j + 1..n {
                        if prefix[i][j] - prefix[i][y] > 0 {
                            dp[i][j][cuts as usize] = (dp[i][j][cuts as usize] + dp[i][y][cuts as usize]) % 1_000_000_007;
                        }
                    }
                }
            }
        }

        dp[0][0][(k - 1) as usize]
    }
}