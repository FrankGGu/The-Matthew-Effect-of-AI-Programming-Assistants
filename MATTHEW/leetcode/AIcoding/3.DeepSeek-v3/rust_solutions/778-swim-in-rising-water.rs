use std::collections::BinaryHeap;

impl Solution {
    pub fn swim_in_water(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut heap = BinaryHeap::new();
        let mut visited = vec![vec![false; n]; n];
        heap.push((-grid[0][0], 0, 0));
        visited[0][0] = true;
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut max_time = 0;

        while let Some((neg_time, i, j)) = heap.pop() {
            let time = -neg_time;
            max_time = max_time.max(time);
            if i == n - 1 && j == n - 1 {
                return max_time;
            }
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] {
                        visited[ni][nj] = true;
                        heap.push((-grid[ni][nj], ni, nj));
                    }
                }
            }
        }
        max_time
    }
}