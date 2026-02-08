use std::cmp::{max, min};

pub fn paths_with_max_score(board: Vec<Vec<char>>) -> Vec<i32> {
    let n = board.len();
    let m = board[0].len();
    let mut dp = vec![vec![0; m + 1]; n + 1];
    let mut count = vec![vec![0; m + 1]; n + 1];

    for i in (0..n).rev() {
        for j in (0..m).rev() {
            if board[i][j] == 'X' {
                continue;
            }
            let score = if board[i][j] == 'E' { 0 } else { board[i][j].to_digit(10).unwrap() as i32 };
            let down = dp[i + 1][j];
            let right = dp[i][j + 1];

            if down > right {
                dp[i][j] = down + score;
                count[i][j] = count[i + 1][j];
            } else if right > down {
                dp[i][j] = right + score;
                count[i][j] = count[i][j + 1];
            } else {
                dp[i][j] = down + score;
                count[i][j] = count[i + 1][j] + count[i][j + 1];
            }

            if i == n - 1 && j == m - 1 {
                count[i][j] = 1;
            }
        }
    }

    if dp[0][0] == 0 {
        return vec![0, 0];
    }

    vec![dp[0][0], count[0][0]]
}