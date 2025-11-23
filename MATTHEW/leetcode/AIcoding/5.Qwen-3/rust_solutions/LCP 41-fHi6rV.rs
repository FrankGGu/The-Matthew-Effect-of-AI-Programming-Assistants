struct Solution;

impl Solution {
    pub fn flip棋盘(棋盘: Vec<Vec<char>>, 走法: Vec<i32>) -> Vec<Vec<char>> {
        let (m, n) = (棋盘.len(), 棋盘[0].len());
        let (x, y) = (走法[0] as usize, 走法[1] as usize);
        if 棋盘[x][y] != '.' {
            return 棋盘;
        }
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)];
        let mut board = 棋盘.clone();
        for &(dx, dy) in &directions {
            let (mut i, mut j) = (x as i32 + dx, y as i32 + dy);
            let mut to_flip = Vec::new();
            while i >= 0 && i < m as i32 && j >= 0 && j < n as i32 {
                let (ci, cj) = (i as usize, j as usize);
                if board[ci][cj] == '.' {
                    break;
                }
                if board[ci][cj] == 'B' {
                    to_flip.iter().for_each(|&(ci, cj)| {
                        board[ci][cj] = 'W';
                    });
                    break;
                }
                to_flip.push((i as usize, j as usize));
                i += dx;
                j += dy;
            }
        }
        board[x][y] = 'W';
        board
    }
}