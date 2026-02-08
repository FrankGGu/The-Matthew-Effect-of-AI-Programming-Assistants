struct Solution;

impl Solution {
    pub fn find_paths(m: i32, n: i32, max_move: i32, start_row: i32, start_column: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let max_move = max_move as usize;
        let start_row = start_row as usize;
        let start_column = start_column as usize;

        let modulo = 1_000_000_007;

        let mut dp = vec![vec![0; n]; m];

        dp[start_row][start_column] = 1;

        let mut ans = 0;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for _move in 0..max_move {
            let mut next_dp = vec![vec![0; n]; m];
            for r in 0..m {
                for c in 0..n {
                    if dp[r][c] == 0 {
                        continue;
                    }

                    for i in 0..4 {
                        let nr = r as isize + dr[i];
                        let nc = c as isize + dc[i];

                        if nr < 0 || nr >= m as isize || nc < 0 || nc >= n as isize {
                            ans = (ans + dp[r][c]) % modulo;
                        } else {
                            next_dp[nr as usize][nc as usize] = (next_dp[nr as usize][nc as usize] + dp[r][c]) % modulo;
                        }
                    }
                }
            }
            dp = next_dp;
        }

        ans
    }
}