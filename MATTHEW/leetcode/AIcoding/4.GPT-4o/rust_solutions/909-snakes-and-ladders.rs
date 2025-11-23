use std::collections::VecDeque;

pub fn snakes_and_ladders(board: Vec<Vec<i32>>) -> i32 {
    let n = board.len();
    let mut visited = vec![false; n * n];
    let mut queue = VecDeque::new();
    queue.push_back(1);
    visited[0] = true;
    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let curr = queue.pop_front().unwrap();
            if curr == n * n {
                return steps;
            }
            for next in curr + 1..=curr + 6 {
                if next > n * n {
                    break;
                }
                let (row, col) = get_position(next, n);
                let next_pos = if board[row][col] != -1 {
                    board[row][col]
                } else {
                    next
                };
                let idx = (next_pos - 1) as usize;
                if !visited[idx] {
                    visited[idx] = true;
                    queue.push_back(next_pos);
                }
            }
        }
        steps += 1;
    }
    -1
}

fn get_position(num: i32, n: usize) -> (usize, usize) {
    let row = (num - 1) / n as i32;
    let col = if row % 2 == 0 {
        (num - 1) % n as i32
    } else {
        n as i32 - 1 - (num - 1) % n as i32
    };
    (row as usize, col as usize)
}