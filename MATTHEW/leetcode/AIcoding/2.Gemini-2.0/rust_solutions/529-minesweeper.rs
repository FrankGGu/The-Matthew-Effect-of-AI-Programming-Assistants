impl Solution {
    pub fn update_board(board: Vec<Vec<char>>, click: Vec<i32>) -> Vec<Vec<char>> {
        let mut board = board;
        let r = click[0] as usize;
        let c = click[1] as usize;

        if board[r][c] == 'M' {
            board[r][c] = 'X';
            return board;
        }

        if board[r][c] == 'E' {
            Self::reveal(&mut board, r, c);
        }

        board
    }

    fn reveal(board: &mut Vec<Vec<char>>, r: usize, c: usize) {
        let rows = board.len();
        let cols = board[0].len();

        if r >= rows || c >= cols {
            return;
        }

        if board[r][c] != 'E' {
            return;
        }

        let mut mine_count = 0;
        for i in -1..=1 {
            for j in -1..=1 {
                if i == 0 && j == 0 {
                    continue;
                }
                let nr = r as i32 + i;
                let nc = c as i32 + j;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    if board[nr as usize][nc as usize] == 'M' || board[nr as usize][nc as usize] == 'X' {
                        mine_count += 1;
                    }
                }
            }
        }

        if mine_count > 0 {
            board[r][c] = (mine_count as u8 + b'0') as char;
        } else {
            board[r][c] = 'B';
            for i in -1..=1 {
                for j in -1..=1 {
                    if i == 0 && j == 0 {
                        continue;
                    }
                    let nr = r as i32 + i;
                    let nc = c as i32 + j;
                    if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                        Self::reveal(board, nr as usize, nc as usize);
                    }
                }
            }
        }
    }
}