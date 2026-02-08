use std::collections::VecDeque;

impl Solution {
    pub fn update_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = mat.len();
        if rows == 0 {
            return Vec::new();
        }
        let cols = mat[0].len();
        if cols == 0 {
            return vec![vec![0; 0]; 0];
        }

        let mut dist = vec![vec![i32::MAX; cols]; rows];
        let mut queue = VecDeque::new();

        for r in 0..rows {
            for c in 0..cols {
                if mat[r][c] == 0 {
                    dist[r][c] = 0;
                    queue.push_back((r, c));
                }
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c)) = queue.pop_front() {
            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if dist[nr][nc] > dist[r][c] + 1 {
                        dist[nr][nc] = dist[r][c] + 1;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        dist
    }
}