impl Solution {
    pub fn find_column_width(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = grid.len();
        if rows == 0 {
            return vec![];
        }
        let cols = grid[0].len();
        let mut res = vec![0; cols];
        for j in 0..cols {
            let mut max_width = 0;
            for i in 0..rows {
                let num = grid[i][j];
                let width = if num == 0 {
                    1
                } else {
                    let mut n = num.abs();
                    let mut len = if num < 0 { 1 } else { 0 };
                    while n > 0 {
                        len += 1;
                        n /= 10;
                    }
                    len
                };
                if width > max_width {
                    max_width = width;
                }
            }
            res[j] = max_width;
        }
        res
    }
}