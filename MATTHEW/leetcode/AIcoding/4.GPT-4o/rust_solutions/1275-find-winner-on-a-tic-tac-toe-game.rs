impl Solution {
    pub fn tictactoe(moves: Vec<Vec<i32>>) -> String {
        let mut board = [[0; 3]; 3];
        for (i, move_) in moves.iter().enumerate() {
            board[move_[0] as usize][move_[1] as usize] = if i % 2 == 0 { 1 } else { 2 };
        }

        let wins = [[(0, 0), (0, 1), (0, 2)],
                    [(1, 0), (1, 1), (1, 2)],
                    [(2, 0), (2, 1), (2, 2)],
                    [(0, 0), (1, 0), (2, 0)],
                    [(0, 1), (1, 1), (2, 1)],
                    [(0, 2), (1, 2), (2, 2)],
                    [(0, 0), (1, 1), (2, 2)],
                    [(0, 2), (1, 1), (2, 0)]];

        for (i, j, k) in wins.iter() {
            let sum = board[i.0][i.1] + board[j.0][j.1] + board[k.0][k.1];
            if sum == 3 {
                return "A".to_string();
            } else if sum == 6 {
                return "B".to_string();
            }
        }

        if moves.len() == 9 {
            return "Draw".to_string();
        }

        "Pending".to_string()
    }
}