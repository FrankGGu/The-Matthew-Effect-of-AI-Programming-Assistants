impl Solution {
    pub fn flip_chess(chessboard: Vec<String>) -> i32 {
        let dirs: [(i32, i32); 8] = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1),  (1, 0),  (1, 1)
        ];
        let m = chessboard.len();
        let n = chessboard[0].len();
        let mut max_flips = 0;

        for i in 0..m {
            for j in 0..n {
                if chessboard[i].as_bytes()[j] != b'.' {
                    continue;
                }
                let mut board = chessboard.clone();
                let mut flips = 0;
                let mut queue = std::collections::VecDeque::new();
                queue.push_back((i, j));
                board[i].replace_range(j..j+1, "X");

                while let Some((x, y)) = queue.pop_front() {
                    for &(dx, dy) in dirs.iter() {
                        let mut nx = x as i32 + dx;
                        let mut ny = y as i32 + dy;
                        let mut path = Vec::new();

                        while nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                            let nx_usize = nx as usize;
                            let ny_usize = ny as usize;
                            match board[nx_usize].as_bytes()[ny_usize] {
                                b'X' => {
                                    for &(px, py) in &path {
                                        board[px].replace_range(py..py+1, "X");
                                        flips += 1;
                                        queue.push_back((px, py));
                                    }
                                    break;
                                },
                                b'O' => {
                                    path.push((nx_usize, ny_usize));
                                    nx += dx;
                                    ny += dy;
                                },
                                _ => break,
                            }
                        }
                    }
                }
                max_flips = max_flips.max(flips);
            }
        }
        max_flips
    }
}