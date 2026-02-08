use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        if grid[0][1] > 1 && grid[1][0] > 1 {
            return -1;
        }
        let m = grid.len();
        let n = grid[0].len();
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut heap = BinaryHeap::new();
        dist[0][0] = 0;
        heap.push(Reverse((0, 0, 0)));

        while let Some(Reverse((time, i, j))) = heap.pop() {
            if i == m - 1 && j == n - 1 {
                return time;
            }
            if time > dist[i][j] {
                continue;
            }
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    let required = grid[ni][nj];
                    let mut new_time = time + 1;
                    if new_time < required {
                        let diff = required - new_time;
                        if diff % 2 == 0 {
                            new_time = required;
                        } else {
                            new_time = required + 1;
                        }
                    }
                    if new_time < dist[ni][nj] {
                        dist[ni][nj] = new_time;
                        heap.push(Reverse((new_time, ni, nj)));
                    }
                }
            }
        }
        -1
    }
}