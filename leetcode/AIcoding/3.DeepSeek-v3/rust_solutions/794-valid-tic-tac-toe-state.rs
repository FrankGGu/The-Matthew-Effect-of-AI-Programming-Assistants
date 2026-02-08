impl Solution {
    pub fn valid_tic_tac_toe(board: Vec<String>) -> bool {
        let mut x_count = 0;
        let mut o_count = 0;
        let mut rows = [0; 3];
        let mut cols = [0; 3];
        let mut diag = 0;
        let mut anti_diag = 0;

        for i in 0..3 {
            let row = board[i].as_bytes();
            for j in 0..3 {
                if row[j] == b'X' {
                    x_count += 1;
                    rows[i] += 1;
                    cols[j] += 1;
                    if i == j {
                        diag += 1;
                    }
                    if i + j == 2 {
                        anti_diag += 1;
                    }
                } else if row[j] == b'O' {
                    o_count += 1;
                    rows[i] -= 1;
                    cols[j] -= 1;
                    if i == j {
                        diag -= 1;
                    }
                    if i + j == 2 {
                        anti_diag -= 1;
                    }
                }
            }
        }

        let x_win = rows.iter().any(|&x| x == 3) || cols.iter().any(|&x| x == 3) || diag == 3 || anti_diag == 3;
        let o_win = rows.iter().any(|&x| x == -3) || cols.iter().any(|&x| x == -3) || diag == -3 || anti_diag == -3;

        if x_win && o_win {
            return false;
        }

        if x_win {
            return x_count == o_count + 1;
        }

        if o_win {
            return x_count == o_count;
        }

        x_count == o_count || x_count == o_count + 1
    }
}