use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn snakes_and_ladders(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len() as i32;
        let num_squares = n * n;

        let mut dist = vec![-1; (num_squares + 1) as usize];
        let mut q: VecDeque<(i32, i32)> = VecDeque::new();

        dist[1 as usize] = 0;
        q.push_back((1, 0));

        while let Some((curr_square, moves)) = q.pop_front() {
            if curr_square == num_squares {
                return moves;
            }

            for i in 1..=6 {
                let next_square_candidate = curr_square + i;

                if next_square_candidate > num_squares {
                    continue;
                }

                let s_idx = next_square_candidate - 1;

                let r_from_bottom = s_idx / n;
                let row = n - 1 - r_from_bottom;

                let col = if r_from_bottom % 2 == 0 {
                    s_idx % n
                } else {
                    n - 1 - (s_idx % n)
                };

                let mut actual_next_square = next_square_candidate;
                let board_val = board[row as usize][col as usize];

                if board_val != -1 {
                    actual_next_square = board_val;
                }

                if dist[actual_next_square as usize] == -1 {
                    dist[actual_next_square as usize] = moves + 1;
                    q.push_back((actual_next_square, moves + 1));
                }
            }
        }

        -1
    }
}