use std::collections::{BinaryHeap, HashSet};

impl Solution {
    pub fn max_points(grid: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut queries_with_indices: Vec<(i32, usize)> = queries.iter().enumerate().map(|(i, &q)| (q, i)).collect();
        queries_with_indices.sort_unstable();

        let mut result = vec![0; queries.len()];
        let mut visited = HashSet::new();
        let mut heap = BinaryHeap::new();
        heap.push((-grid[0][0], 0, 0));
        visited.insert((0, 0));
        let mut count = 0;

        for (q, idx) in queries_with_indices {
            while let Some(&(val, i, j)) = heap.peek() {
                let val = -val;
                if val >= q {
                    break;
                }
                heap.pop();
                count += 1;
                for (di, dj) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let ni = i as i32 + di;
                    let nj = j as i32 + dj;
                    if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                        let ni = ni as usize;
                        let nj = nj as usize;
                        if !visited.contains(&(ni, nj)) {
                            visited.insert((ni, nj));
                            heap.push((-grid[ni][nj], ni, nj));
                        }
                    }
                }
            }
            result[idx] = count;
        }
        result
    }
}