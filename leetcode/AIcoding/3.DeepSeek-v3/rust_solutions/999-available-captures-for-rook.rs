impl Solution {
    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let mut rook_pos = (0, 0);
        'outer: for i in 0..8 {
            for j in 0..8 {
                if board[i][j] == 'R' {
                    rook_pos = (i as i32, j as i32);
                    break 'outer;
                }
            }
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut captures = 0;

        for dir in directions.iter() {
            let (mut x, mut y) = (rook_pos.0 + dir.0, rook_pos.1 + dir.1);
            while x >= 0 && x < 8 && y >= 0 && y < 8 {
                let cell = board[x as usize][y as usize];
                if cell == 'B' {
                    break;
                }
                if cell == 'p' {
                    captures += 1;
                    break;
                }
                x += dir.0;
                y += dir.1;
            }
        }

        captures
    }
}