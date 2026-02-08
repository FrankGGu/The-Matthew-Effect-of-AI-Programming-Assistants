impl Solution {
    pub fn paths_with_max_score(board: Vec<String>) -> Vec<i32> {
        let n = board.len();
        let board: Vec<Vec<char>> = board.into_iter().map(|s| s.chars().collect()).collect();
        let mut dp = vec![vec![(0, 0); n]; n];
        dp[n - 1][n - 1] = (0, 1);

        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if board[i][j] == 'X' {
                    continue;
                }

                let mut max_score = -1;
                let mut paths = 0;

                if i + 1 < n && dp[i + 1][j].1 > 0 {
                    if dp[i + 1][j].0 > max_score {
                        max_score = dp[i + 1][j].0;
                        paths = dp[i + 1][j].1;
                    } else if dp[i + 1][j].0 == max_score {
                        paths = (paths + dp[i + 1][j].1) % 1000000007;
                    }
                }

                if j + 1 < n && dp[i][j + 1].1 > 0 {
                    if dp[i][j + 1].0 > max_score {
                        max_score = dp[i][j + 1].0;
                        paths = dp[i][j + 1].1;
                    } else if dp[i][j + 1].0 == max_score {
                        paths = (paths + dp[i][j + 1].1) % 1000000007;
                    }
                }

                if i + 1 < n && j + 1 < n && dp[i + 1][j + 1].1 > 0 {
                    if dp[i + 1][j + 1].0 > max_score {
                        max_score = dp[i + 1][j + 1].0;
                        paths = dp[i + 1][j + 1].1;
                    } else if dp[i + 1][j + 1].0 == max_score {
                        paths = (paths + dp[i + 1][j + 1].1) % 1000000007;
                    }
                }

                if max_score != -1 {
                    let score = if board[i][j] == 'E' {
                        0
                    } else {
                        board[i][j].to_digit(10).unwrap() as i32
                    };
                    dp[i][j] = (max_score + score, paths);
                }
            }
        }

        if dp[0][0].1 == 0 {
            vec![0, 0]
        } else {
            vec![dp[0][0].0, dp[0][0].1]
        }
    }
}