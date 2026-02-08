impl Solution {
    pub fn get_biggest_three(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let (m, n) = (grid.len(), grid[0].len());
        let mut sums = std::collections::HashSet::new();

        for r in 0..m {
            for c in 0..n {
                let mut total = 0;
                for k in 0..std::cmp::min(m, n) {
                    if r + k < m && c + k < n && c >= k {
                        total += grid[r + k][c - k];
                        total += grid[r + k][c + k];
                        total += grid[r][c];
                        sums.insert(total);
                    } else {
                        break;
                    }
                }
            }
        }

        let mut result: Vec<i32> = sums.into_iter().collect();
        result.sort_unstable_by(|a, b| b.cmp(a));
        result.truncate(3);
        result
    }
}