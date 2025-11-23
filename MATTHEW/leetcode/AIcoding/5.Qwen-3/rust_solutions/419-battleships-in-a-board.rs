impl Solution {
    pub fn count_battleships(mut board: Vec<Vec<char>>) -> i32 {
        let mut count = 0;
        let rows = board.len();
        let cols = board[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if board[i][j] == 'X' && (i == 0 || board[i-1][j] != 'X') && (j == 0 || board[i][j-1] != 'X') {
                    count += 1;
                }
            }
        }

        count
    }
}