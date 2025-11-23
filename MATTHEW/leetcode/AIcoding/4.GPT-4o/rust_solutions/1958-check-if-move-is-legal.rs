pub fn check_move(board: Vec<Vec<char>>, row: i32, col: i32, color: char) -> bool {
    let directions = vec![(1, 0), (0, 1), (1, 1), (1, -1)];
    let (n, m) = (board.len() as i32, board[0].len() as i32);

    for (dx, dy) in directions {
        let mut x = row + dx;
        let mut y = col + dy;
        let mut count = 0;

        while x >= 0 && x < n && y >= 0 && y < m {
            if board[x as usize][y as usize] == color {
                count += 1;
            } else {
                break;
            }
            x += dx;
            y += dy;
        }

        x = row - dx;
        y = col - dy;

        while x >= 0 && x < n && y >= 0 && y < m {
            if board[x as usize][y as usize] == color {
                count += 1;
            } else {
                break;
            }
            x -= dx;
            y -= dy;
        }

        if count >= 2 {
            return true;
        }
    }

    false
}