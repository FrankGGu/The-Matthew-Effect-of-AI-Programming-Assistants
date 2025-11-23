use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_reachable(
        board: Vec<String>,
        source: Vec<i32>,
        target: Vec<i32>,
    ) -> bool {
        let m = board.len();
        let n = board[0].len();

        let mut visited: HashSet<(i32, i32)> = HashSet::new();
        let mut queue: VecDeque<(i32, i32)> = VecDeque::new();

        queue.push_back((source[0], source[1]));
        visited.insert((source[0], source[1]));

        let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((x, y)) = queue.pop_front() {
            if x == target[0] && y == target[1] {
                return true;
            }

            for (dx, dy) in directions {
                let nx = x + dx;
                let ny = y + dy;

                if nx >= 0
                    && nx < m as i32
                    && ny >= 0
                    && ny < n as i32
                    && board[nx as usize].as_bytes()[ny as usize] == b'.'
                    && !visited.contains(&(nx, ny))
                {
                    queue.push_back((nx, ny));
                    visited.insert((nx, ny));
                }
            }
        }

        false
    }
}