impl Solution {
    pub fn check_if_grid_satisfies_conditions(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            let mut row = grid[i].clone();
            row.sort();
            let mut count = 0;
            for j in 0..n {
                if grid[i][j] == row[j] {
                    count += 1;
                }
            }
            if count != n {
                return false;
            }
        }

        for j in 0..n {
            let mut col: Vec<i32> = (0..m).map(|i| grid[i][j]).collect();
            col.sort();
            let mut count = 0;
            for i in 0..m {
                let mut temp_col: Vec<i32> = (0..m).map(|k| grid[k][j]).collect();
                temp_col.sort();
                if grid[i][j] == col[i] {
                    count += 1;
                }
            }
            if count != m {
                return false;
            }
        }

        true
    }
}