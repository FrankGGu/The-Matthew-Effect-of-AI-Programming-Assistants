impl Solution {
    pub fn matrix_score(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            if grid[i][0] == 0 {
                for j in 0..n {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        for j in 1..n {
            let mut count = 0;
            for i in 0..m {
                if grid[i][j] == 1 {
                    count += 1;
                }
            }
            if count < m - count {
                for i in 0..m {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        let mut res = 0;
        for i in 0..m {
            let mut num = 0;
            for j in 0..n {
                num = (num << 1) | grid[i][j];
            }
            res += num;
        }

        res
    }
}