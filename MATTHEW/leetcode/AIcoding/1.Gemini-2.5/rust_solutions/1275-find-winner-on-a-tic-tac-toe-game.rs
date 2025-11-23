impl Solution {
    pub fn find_winner(moves: Vec<Vec<i32>>) -> String {
        let mut rows = [0; 3];
        let mut cols = [0; 3];
        let mut diag1 = 0; // Main diagonal (r == c)
        let mut diag2 = 0; // Anti-diagonal (r + c == 2)

        for (i, mv) in moves.iter().enumerate() {
            let r = mv[0] as usize;
            let c = mv[1] as usize;

            let player_val = if i % 2 == 0 { 1 } else { -1 }; // Player A: 1, Player B: -1

            rows[r] += player_val;
            cols[c] += player_val;

            if r == c {
                diag1 += player_val;
            }
            if r + c == 2 {
                diag2 += player_val;
            }

            if rows[r].abs() == 3 || cols[c].abs() == 3 || diag1.abs() == 3 || diag2.abs() == 3 {
                return if player_val == 1 {
                    "A".to_string()
                } else {
                    "B".to_string()
                };
            }
        }

        if moves.len() == 9 {
            "Draw".to_string()
        } else {
            "Pending".to_string()
        }
    }
}