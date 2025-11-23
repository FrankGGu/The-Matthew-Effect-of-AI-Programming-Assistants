impl Solution {
    pub fn count_battleships(board: Vec<Vec<char>>) -> i32 {
        let mut count = 0;
        let rows = board.len();
        let cols = if rows > 0 { board[0].len() } else { 0 };

        for i in 0..rows {
            for j in 0..cols {
                if board[i][j] == 'X' {
                    if i == 0 || board[i - 1][j] == '.' {
                        if j == 0 || board[i][j - 1] == '.' {
                            count += 1;
                        }
                    }
                }
            }
        }
        count
    }
}