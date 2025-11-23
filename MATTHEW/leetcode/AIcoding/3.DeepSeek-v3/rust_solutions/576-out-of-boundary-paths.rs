impl Solution {
    pub fn find_paths(m: i32, n: i32, max_move: i32, start_row: i32, start_column: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let max_move = max_move as usize;
        let start_row = start_row as usize;
        let start_column = start_column as usize;
        let modulo = 1_000_000_007;
        let mut dp = vec![vec![vec![0; n]; m]; max_move + 1];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for step in 1..=max_move {
            for i in 0..m {
                for j in 0..n {
                    for dir in &directions {
                        let ni = i as i32 + dir.0;
                        let nj = j as i32 + dir.1;
                        if ni < 0 || nj < 0 || ni >= m as i32 || nj >= n as i32 {
                            dp[step][i][j] += 1;
                        } else {
                            let ni = ni as usize;
                            let nj = nj as usize;
                            dp[step][i][j] = (dp[step][i][j] + dp[step - 1][ni][nj]) % modulo;
                        }
                    }
                }
            }
        }

        dp[max_move][start_row][start_column] % modulo
    }
}