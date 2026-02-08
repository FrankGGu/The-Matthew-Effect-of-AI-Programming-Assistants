impl Solution {
    pub fn find_column_width(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = vec![0; n];

        for j in 0..n {
            let mut max_width = 0;
            for i in 0..m {
                let num_str = grid[i][j].to_string();
                max_width = max_width.max(num_str.len() as i32);
            }
            result[j] = max_width;
        }

        result
    }
}