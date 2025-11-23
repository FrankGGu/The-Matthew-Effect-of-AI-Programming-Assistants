use std::collections::VecDeque;

impl Solution {
    pub fn sliding_puzzle(board: Vec<Vec<i32>>) -> i32 {
        let target = [[1, 2, 3], [4, 5, 0]];
        let mut visited = std::collections::HashSet::new();
        let mut queue = VecDeque::new();
        let mut start = 0;

        for i in 0..2 {
            for j in 0..3 {
                start = start * 10 + board[i][j];
            }
        }

        if start == 123450 {
            return 0;
        }

        queue.push_back((start, 0));
        visited.insert(start);

        let directions = vec![-1, 1, -3, 3];

        while let Some((current, steps)) = queue.pop_front() {
            let zero_pos = (current as f64).log(10.0).floor() as usize;
            let zero_row = zero_pos / 3;
            let zero_col = zero_pos % 3;

            for &d in &directions {
                let new_zero_pos = (zero_row * 3 + zero_col as isize + d) as usize;
                if d == -1 && zero_col == 0 || d == 1 && zero_col == 2 { continue; }
                if new_zero_pos < 0 || new_zero_pos > 5 { continue; }

                let mut new_current = current;
                let new_zero_pos_value = (new_zero_pos as isize - d) as usize;
                let new_zero_value = (new_current / 10i32.pow(new_zero_pos_value as u32) % 10) as i32;

                new_current = new_current - new_zero_value * 10i32.pow(zero_pos as u32) + new_zero_value * 10i32.pow(new_zero_pos as u32);

                if visited.insert(new_current) {
                    if new_current == 123450 {
                        return steps + 1;
                    }
                    queue.push_back((new_current, steps + 1));
                }
            }
        }

        -1
    }
}