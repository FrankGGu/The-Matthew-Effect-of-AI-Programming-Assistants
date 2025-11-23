impl Solution {
    pub fn number_of_right_triangles(grid: Vec<Vec<i32>>) -> i64 {
        let m = grid.len();
        let n = grid[0].len();
        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    row_counts[i] += 1;
                    col_counts[j] += 1;
                }
            }
        }

        let mut res = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    res += (row_counts[i] - 1) * (col_counts[j] - 1);
                }
            }
        }

        res
    }
}