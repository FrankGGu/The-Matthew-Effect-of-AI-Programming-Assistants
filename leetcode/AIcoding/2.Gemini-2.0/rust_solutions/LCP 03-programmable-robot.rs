impl Solution {
    pub fn is_programmable(&self, pos: i32, board: Vec<Vec<i32>>, instructions: String) -> bool {
        let mut x = 0;
        let mut y = pos as usize;
        let m = board.len();
        let n = board[0].len();
        let target = board[0][y];

        for c in instructions.chars() {
            match c {
                'U' => {
                    if x > 0 {
                        x -= 1;
                        if board[x][y] != 0 && board[x][y] != target {
                            return true;
                        }
                    }
                }
                'D' => {
                    if x < m - 1 {
                        x += 1;
                        if board[x][y] != 0 && board[x][y] != target {
                            return true;
                        }
                    }
                }
                'L' => {
                    if y > 0 {
                        y -= 1;
                        if board[x][y] != 0 && board[x][y] != target {
                            return true;
                        }
                    }
                }
                'R' => {
                    if y < n - 1 {
                        y += 1;
                        if board[x][y] != 0 && board[x][y] != target {
                            return true;
                        }
                    }
                }
                _ => {}
            }
        }

        false
    }
}