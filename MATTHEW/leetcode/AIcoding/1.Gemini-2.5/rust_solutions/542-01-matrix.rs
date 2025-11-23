use std::collections::VecDeque;

impl Solution {
    pub fn update_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        if m == 0 {
            return vec![];
        }
        let n = mat[0].len();
        if n == 0 {
            return vec![vec![]];
        }

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; m];
        let mut queue: VecDeque<(usize, usize)> = VecDeque::new();

        for r in 0..m {
            for c in 0..n {
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

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if dist[r][c] + 1 < dist[nr][nc] {
                        dist[nr][nc] = dist[r][c] + 1;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        dist
    }
}