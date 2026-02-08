use std::collections::{BinaryHeap, VecDeque};

impl Solution {
    pub fn maximum_safeness_factor(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if grid[0][0] == 1 || grid[n - 1][n - 1] == 1 {
            return 0;
        }

        let mut dist = vec![vec![i32::MAX; n]; n];
        let mut q = VecDeque::new();

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    dist[i][j] = 0;
                    q.push_back((i, j));
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        while let Some((i, j)) = q.pop_front() {
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if dist[ni][nj] > dist[i][j] + 1 {
                        dist[ni][nj] = dist[i][j] + 1;
                        q.push_back((ni, nj));
                    }
                }
            }
        }

        let mut heap = BinaryHeap::new();
        heap.push((dist[0][0], 0, 0));
        let mut max_sf = vec![vec![-1; n]; n];
        max_sf[0][0] = dist[0][0];

        while let Some((d, i, j)) = heap.pop() {
            if i == n - 1 && j == n - 1 {
                return d;
            }
            if d < max_sf[i][j] {
                continue;
            }
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    let new_d = d.min(dist[ni][nj]);
                    if new_d > max_sf[ni][nj] {
                        max_sf[ni][nj] = new_d;
                        heap.push((new_d, ni, nj));
                    }
                }
            }
        }

        0
    }
}