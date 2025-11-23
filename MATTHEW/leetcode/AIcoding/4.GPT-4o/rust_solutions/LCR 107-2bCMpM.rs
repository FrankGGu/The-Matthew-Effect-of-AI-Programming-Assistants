use std::collections::VecDeque;

impl Solution {
    pub fn update_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = mat.len();
        let cols = mat[0].len();
        let mut distances = vec![vec![i32::MAX; cols]; rows];
        let mut queue = VecDeque::new();

        for r in 0..rows {
            for c in 0..cols {
                if mat[r][c] == 0 {
                    distances[r][c] = 0;
                    queue.push_back((r, c));
                }
            }
        }

        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        while let Some((r, c)) = queue.pop_front() {
            for (dr, dc) in &directions {
                let nr = r as isize + dr;
                let nc = c as isize + dc;
                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if distances[nr][nc] > distances[r][c] + 1 {
                        distances[nr][nc] = distances[r][c] + 1;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        distances
    }
}