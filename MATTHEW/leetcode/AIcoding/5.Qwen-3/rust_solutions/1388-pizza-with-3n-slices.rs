impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn amount_of_money(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut pq = BinaryHeap::new();
        for i in 0..n {
            for j in 0..m {
                pq.push((grid[i][j], i, j));
            }
        }

        let mut res = 0;
        let mut visited = vec![vec![false; m]; n];

        while let Some((val, i, j)) = pq.pop() {
            if visited[i][j] {
                continue;
            }
            res += val;
            visited[i][j] = true;
            if i > 0 && !visited[i-1][j] {
                pq.push((grid[i-1][j], i-1, j));
            }
            if i < n-1 && !visited[i+1][j] {
                pq.push((grid[i+1][j], i+1, j));
            }
            if j > 0 && !visited[i][j-1] {
                pq.push((grid[i][j-1], i, j-1));
            }
            if j < m-1 && !visited[i][j+1] {
                pq.push((grid[i][j+1], i, j+1));
            }
        }

        res
    }
}
}