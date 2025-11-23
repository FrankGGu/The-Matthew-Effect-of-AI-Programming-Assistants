impl Solution {
    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let mut rook_r = 0;
        let mut rook_c = 0;

        for r in 0..8 {
            for c in 0..8 {
                if board[r][c] == 'R' {
                    rook_r = r;
                    rook_c = c;
                    break;
                }
            }
        }

        let mut captures = 0;
        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let mut r = rook_r;
            let mut c = rook_c;

            loop {
                r = (r as isize + dr[i]) as usize;
                c = (c as isize + dc[i]) as usize;

                if r >= 8 || c >= 8 {
                    break;
                }

                match board[r][c] {
                    'p' => {
                        captures += 1;
                        break;
                    }
                    'B' => {
                        break;
                    }
                    '.' => {
                        continue;
                    }
                    _ => { // Should not happen for 'R' but good to be exhaustive
                        break;
                    }
                }
            }
        }
        captures
    }
}