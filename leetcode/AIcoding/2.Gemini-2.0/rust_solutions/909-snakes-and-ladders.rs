use std::collections::VecDeque;

impl Solution {
    pub fn snakes_and_ladders(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let mut flat_board = vec![0; n * n + 1];
        let mut index = 1;
        let mut row = n - 1;
        let mut col = 0;
        let mut dir = 1;

        while index <= n * n {
            flat_board[index] = board[row][col];
            index += 1;

            if dir == 1 {
                col += 1;
                if col == n {
                    col = n - 1;
                    row -= 1;
                    dir = -1;
                }
            } else {
                col -= 1;
                if col == -1 {
                    col = 0;
                    row -= 1;
                    dir = 1;
                }
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back((1, 0));
        let mut visited = vec![false; n * n + 1];
        visited[1] = true;

        while !queue.is_empty() {
            let (curr, steps) = queue.pop_front().unwrap();

            if curr == n * n {
                return steps;
            }

            for next in curr + 1..=std::cmp::min(curr + 6, n * n) {
                let dest = if flat_board[next] != -1 {
                    flat_board[next] as usize
                } else {
                    next
                };

                if !visited[dest] {
                    visited[dest] = true;
                    queue.push_back((dest, steps + 1));
                }
            }
        }

        -1
    }
}