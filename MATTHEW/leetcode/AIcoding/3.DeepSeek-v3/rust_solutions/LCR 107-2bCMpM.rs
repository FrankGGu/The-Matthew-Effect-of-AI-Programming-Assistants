use std::collections::VecDeque;

impl Solution {
    pub fn update_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 0 {
                    dist[i][j] = 0;
                    queue.push_back((i, j));
                }
            }
        }

        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((i, j)) = queue.pop_front() {
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if dist[ni][nj] > dist[i][j] + 1 {
                        dist[ni][nj] = dist[i][j] + 1;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        dist
    }
}