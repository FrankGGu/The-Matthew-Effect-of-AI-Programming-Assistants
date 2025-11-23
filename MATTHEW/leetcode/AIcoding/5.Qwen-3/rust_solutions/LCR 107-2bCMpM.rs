impl Solution {

use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn update_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut dist = vec![vec![0; n]; m];
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 0 {
                    queue.push_back((i, j));
                    visited[i][j] = true;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let ni = i as i32 + dx;
                let nj = j as i32 + dy;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 && !visited[ni as usize][nj as usize] {
                    visited[ni as usize][nj as usize] = true;
                    dist[ni as usize][nj as usize] = dist[i][j] + 1;
                    queue.push_back((ni as usize, nj as usize));
                }
            }
        }

        dist
    }
}
}