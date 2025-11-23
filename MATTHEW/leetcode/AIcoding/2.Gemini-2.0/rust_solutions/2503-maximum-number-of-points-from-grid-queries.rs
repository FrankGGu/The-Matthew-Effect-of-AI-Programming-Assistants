use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_points(grid: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut sorted_queries: Vec<(i32, usize)> = queries.iter().enumerate().map(|(i, &q)| (q, i)).collect();
        sorted_queries.sort_unstable();

        let mut ans = vec![0; queries.len()];
        let mut visited = vec![vec![false; n]; m];
        let mut heap: BinaryHeap<(Reverse<i32>, usize, usize)> = BinaryHeap::new();
        heap.push((Reverse(grid[0][0]), 0, 0));
        visited[0][0] = true;

        let mut points = 0;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for (query, index) in sorted_queries {
            while let Some((Reverse(val), row, col)) = heap.pop() {
                if val >= query {
                    heap.push((Reverse(val), row, col));
                    break;
                }

                points += 1;

                for &(dr, dc) in &directions {
                    let new_row = row as i32 + dr;
                    let new_col = col as i32 + dc;

                    if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                        let new_row = new_row as usize;
                        let new_col = new_col as usize;

                        if !visited[new_row][new_col] {
                            heap.push((Reverse(grid[new_row][new_col]), new_row, new_col));
                            visited[new_row][new_col] = true;
                        }
                    }
                }
            }
            ans[index] = points;
        }

        ans
    }
}