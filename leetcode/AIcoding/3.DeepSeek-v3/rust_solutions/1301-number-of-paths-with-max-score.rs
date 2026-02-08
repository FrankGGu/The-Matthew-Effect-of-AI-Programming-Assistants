impl Solution {
    pub fn paths_with_max_score(board: Vec<String>) -> Vec<i32> {
        let n = board.len();
        let m = board[0].len();
        let mod_num = 1_000_000_007;
        let mut dp = vec![vec![(0, 0); m]; n];
        dp[n - 1][m - 1] = (0, 1);

        for i in (0..n).rev() {
            for j in (0..m).rev() {
                if board[i].as_bytes()[j] == b'X' {
                    dp[i][j] = (0, 0);
                    continue;
                }
                if i == n - 1 && j == m - 1 {
                    continue;
                }
                let mut max_score = 0;
                let mut count = 0;
                let current_char = board[i].as_bytes()[j];
                let current_val = if current_char == b'E' { 0 } else { (current_char - b'0') as i32 };

                for (di, dj) in &[(1, 0), (0, 1), (1, 1)] {
                    let ni = i + di;
                    let nj = j + dj;
                    if ni < n && nj < m {
                        let (score, cnt) = dp[ni][nj];
                        if cnt > 0 {
                            if score > max_score {
                                max_score = score;
                                count = cnt;
                            } else if score == max_score {
                                count = (count + cnt) % mod_num;
                            }
                        }
                    }
                }
                if count > 0 {
                    dp[i][j] = (max_score + current_val, count);
                } else {
                    dp[i][j] = (0, 0);
                }
            }
        }

        let (max_score, count) = dp[0][0];
        if count == 0 {
            vec![0, 0]
        } else {
            vec![max_score, count]
        }
    }
}