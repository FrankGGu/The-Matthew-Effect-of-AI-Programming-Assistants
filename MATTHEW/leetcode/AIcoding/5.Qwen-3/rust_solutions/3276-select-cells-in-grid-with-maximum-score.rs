impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut pq = BinaryHeap::new();

        for i in 0..m {
            for j in 0..n {
                pq.push((grid[i][j], i, j));
            }
        }

        let mut score = 0;
        let mut visited = vec![vec![false; n]; m];

        while let Some((val, i, j)) = pq.pop() {
            if visited[i][j] {
                continue;
            }

            score += val;
            visited[i][j] = true;

            for (di, dj) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;

                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] {
                        pq.push((grid[ni][nj], ni, nj));
                    }
                }
            }
        }

        score
    }
}
}