impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn update_matrix(mut matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 0 {
                    queue.push_back((i, j));
                } else {
                    matrix[i][j] = i32::MAX;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let ni = i as i32 + dx;
                let nj = j as i32 + dy;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if matrix[ni][nj] > matrix[i][j] + 1 {
                        matrix[ni][nj] = matrix[i][j] + 1;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        matrix
    }
}
}