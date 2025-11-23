impl Solution {
    pub fn update_board(board: Vec<Vec<char>>, click: Vec<i32>) -> Vec<Vec<char>> {
        let mut board = board;
        let (x, y) = (click[0] as usize, click[1] as usize);
        if board[x][y] == 'M' {
            board[x][y] = 'X';
            return board;
        }
        let dirs = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
        let m = board.len() as i32;
        let n = board[0].len() as i32;
        let mut stack = vec![(x as i32, y as i32)];
        while let Some((i, j)) = stack.pop() {
            if board[i as usize][j as usize] != 'E' {
                continue;
            }
            let mut mines = 0;
            let mut neighbors = vec![];
            for &(di, dj) in dirs.iter() {
                let ni = i + di;
                let nj = j + dj;
                if ni >= 0 && ni < m && nj >= 0 && nj < n {
                    let c = board[ni as usize][nj as usize];
                    if c == 'M' || c == 'X' {
                        mines += 1;
                    } else if c == 'E' {
                        neighbors.push((ni, nj));
                    }
                }
            }
            if mines > 0 {
                board[i as usize][j as usize] = (mines as u8 + b'0') as char;
            } else {
                board[i as usize][j as usize] = 'B';
                stack.extend(neighbors);
            }
        }
        board
    }
}