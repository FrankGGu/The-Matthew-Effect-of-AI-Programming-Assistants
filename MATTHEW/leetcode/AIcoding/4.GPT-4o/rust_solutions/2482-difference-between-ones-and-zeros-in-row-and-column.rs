impl Solution {
    pub fn ones_and_zeros(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut rows = vec![0; grid.len()];
        let mut cols = vec![0; grid[0].len()];

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    rows[i] += 1;
                    cols[j] += 1;
                }
            }
        }

        let mut result = vec![vec![0; grid[0].len()]; grid.len()];
        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                result[i][j] = rows[i] - (grid[i][j] as i32) + cols[j] - (grid[i][j] as i32);
            }
        }

        result
    }
}