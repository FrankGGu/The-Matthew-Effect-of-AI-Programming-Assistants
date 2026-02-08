impl Solution {
    pub fn tictactoe(moves: Vec<Vec<i32>>) -> String {
        let mut board = [[0; 3]; 3];
        for (i, move_) in moves.iter().enumerate() {
            let row = move_[0] as usize;
            let col = move_[1] as usize;
            board[row][col] = if i % 2 == 0 { 1 } else { 2 };
        }

        for i in 0..3 {
            if board[i][0] != 0 && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                return if board[i][0] == 1 { "A".to_string() } else { "B".to_string() };
            }
            if board[0][i] != 0 && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                return if board[0][i] == 1 { "A".to_string() } else { "B".to_string() };
            }
        }

        if board[0][0] != 0 && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return if board[0][0] == 1 { "A".to_string() } else { "B".to_string() };
        }
        if board[0][2] != 0 && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return if board[0][2] == 1 { "A".to_string() } else { "B".to_string() };
        }

        if moves.len() == 9 {
            return "Draw".to_string();
        } else {
            return "Pending".to_string();
        }
    }
}