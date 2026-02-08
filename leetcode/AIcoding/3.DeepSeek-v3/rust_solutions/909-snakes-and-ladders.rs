use std::collections::VecDeque;

impl Solution {
    pub fn snakes_and_ladders(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let mut visited = vec![false; n * n + 1];
        let mut queue = VecDeque::new();
        queue.push_back((1, 0));
        visited[1] = true;

        while let Some((pos, steps)) = queue.pop_front() {
            if pos == n * n {
                return steps;
            }
            for next_pos in (pos + 1)..=(pos + 6).min(n * n) {
                let (r, c) = Self::get_coordinates(next_pos, n);
                let dest = if board[r][c] != -1 {
                    board[r][c] as usize
                } else {
                    next_pos
                };
                if !visited[dest] {
                    visited[dest] = true;
                    queue.push_back((dest, steps + 1));
                }
            }
        }
        -1
    }

    fn get_coordinates(pos: usize, n: usize) -> (usize, usize) {
        let row = (pos - 1) / n;
        let col = (pos - 1) % n;
        let r = n - 1 - row;
        let c = if row % 2 == 0 { col } else { n - 1 - col };
        (r, c)
    }
}