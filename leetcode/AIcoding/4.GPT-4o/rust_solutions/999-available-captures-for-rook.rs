impl Solution {
    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let mut count = 0;
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        let (mut rook_x, mut rook_y) = (0, 0);

        for i in 0..8 {
            for j in 0..8 {
                if board[i][j] == 'R' {
                    rook_x = i;
                    rook_y = j;
                    break;
                }
            }
        }

        for (dx, dy) in directions {
            let mut x = rook_x as isize;
            let mut y = rook_y as isize;
            while x >= 0 && x < 8 && y >= 0 && y < 8 {
                match board[x as usize][y as usize] {
                    'B' => break,
                    'p' => {
                        count += 1;
                        break;
                    },
                    _ => {}
                }
                x += dx;
                y += dy;
            }
        }

        count
    }
}