impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn maximize_value(operations: Vec<Vec<i32>>, x: i32, y: i32) -> i32 {
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        let mut visited = std::collections::HashSet::new();
        visited.insert((0, 0));

        while let Some((i, j)) = q.pop_front() {
            if i == operations.len() - 1 && j == operations[0].len() - 1 {
                return operations[i][j];
            }

            for (di, dj) in [(0, 1), (1, 0)] {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < operations.len() as i32 && nj >= 0 && nj < operations[0].len() as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited.contains(&(ni, nj)) {
                        visited.insert((ni, nj));
                        q.push_back((ni, nj));
                    }
                }
            }
        }

        0
    }
}
}