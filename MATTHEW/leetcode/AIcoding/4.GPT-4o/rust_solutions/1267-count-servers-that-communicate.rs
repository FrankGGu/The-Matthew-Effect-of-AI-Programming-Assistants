impl Solution {
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let mut rows = vec![0; grid.len()];
        let mut cols = vec![0; grid[0].len()];
        let mut count = 0;

        for r in 0..grid.len() {
            for c in 0..grid[0].len() {
                if grid[r][c] == 1 {
                    rows[r] += 1;
                    cols[c] += 1;
                }
            }
        }

        for r in 0..grid.len() {
            for c in 0..grid[0].len() {
                if grid[r][c] == 1 && (rows[r] > 1 || cols[c] > 1) {
                    count += 1;
                }
            }
        }

        count
    }
}