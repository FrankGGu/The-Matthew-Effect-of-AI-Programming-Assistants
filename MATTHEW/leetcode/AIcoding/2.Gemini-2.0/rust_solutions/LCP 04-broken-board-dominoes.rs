impl Solution {
    pub fn domino(m: i32, n: i32, broken: Vec<Vec<i32>>) -> i32 {
        let mut board = vec![vec![0; n as usize]; m as usize];
        for b in &broken {
            board[b[0] as usize][b[1] as usize] = 1;
        }

        let mut count = 0;
        for i in 0..m as usize {
            for j in 0..n as usize {
                if board[i][j] == 0 {
                    if i + 1 < m as usize && board[i + 1][j] == 0 {
                        count += 1;
                        board[i][j] = 1;
                        board[i + 1][j] = 1;
                    } else if j + 1 < n as usize && board[i][j + 1] == 0 {
                        count += 1;
                        board[i][j] = 1;
                        board[i][j + 1] = 1;
                    }
                }
            }
        }

        count
    }
}