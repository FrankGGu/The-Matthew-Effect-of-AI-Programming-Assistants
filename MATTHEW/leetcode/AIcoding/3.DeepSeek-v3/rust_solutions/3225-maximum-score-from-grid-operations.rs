use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![std::i32::MIN; n]; m];
        let mut heap = BinaryHeap::new();

        dp[0][0] = 0;
        heap.push((grid[0][0], 0, 0));

        let dirs = vec![(0, 1), (1, 0)];

        while let Some((val, i, j)) = heap.pop() {
            for (di, dj) in &dirs {
                let ni = i + di;
                let nj = j + dj;
                if ni < m && nj < n {
                    let new_score = dp[i][j] + if grid[ni][nj] > val { grid[ni][nj] - val } else { 0 };
                    if new_score > dp[ni][nj] {
                        dp[ni][nj] = new_score;
                        heap.push((grid[ni][nj], ni, nj));
                    }
                }
            }
        }

        dp[m - 1][n - 1]
    }
}