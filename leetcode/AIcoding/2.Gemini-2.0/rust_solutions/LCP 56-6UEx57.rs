impl Solution {
    pub fn conveyor_belt(matrix: Vec<String>, start: Vec<i32>, end: Vec<i32>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut queue = std::collections::VecDeque::new();
        let start_row = start[0] as usize;
        let start_col = start[1] as usize;
        let end_row = end[0] as usize;
        let end_col = end[1] as usize;

        dist[start_row][start_col] = 0;
        queue.push_back((start_row, start_col));

        while let Some((row, col)) = queue.pop_front() {
            let current_dist = dist[row][col];

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
            let symbols = ['>', '<', 'v', '^'];

            for (i, &(dr, dc)) in directions.iter().enumerate().zip(symbols.iter()) {
                let new_row = (row as i32 + dr) as usize;
                let new_col = (col as i32 + dc) as usize;

                if new_row < m && new_col < n {
                    let cost = if matrix[row].chars().nth(col).unwrap() == *dc {
                        0
                    } else {
                        1
                    };

                    if current_dist + cost < dist[new_row][new_col] {
                        dist[new_row][new_col] = current_dist + cost;
                        if cost == 0 {
                            queue.push_front((new_row, new_col));
                        } else {
                            queue.push_back((new_row, new_col));
                        }
                    }
                }
            }
        }

        dist[end_row][end_col]
    }
}