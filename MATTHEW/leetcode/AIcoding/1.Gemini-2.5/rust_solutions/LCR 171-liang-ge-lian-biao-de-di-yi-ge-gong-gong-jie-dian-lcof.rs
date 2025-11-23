impl Solution {
    pub fn find_fresh_rows(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut col_counts = vec![0; n];
        let mut single_one_rows = vec![-1; n]; 

        for r_idx in 0..m {
            for c_idx in 0..n {
                if grid[r_idx][c_idx] == 1 {
                    col_counts[c_idx] += 1;
                    if col_counts[c_idx] == 1 {
                        single_one_rows[c_idx] = r_idx as i32;
                    } else if col_counts[c_idx] == 2 {
                        single_one_rows[c_idx] = -1; 
                    }
                }
            }
        }

        for r_idx in 0..m {
            let mut is_valid_row = true;
            for c_idx in 0..n {
                if grid[r_idx][c_idx] == 1 {
                    if single_one_rows[c_idx] == r_idx as i32 {
                        is_valid_row = false;
                        break; 
                    }
                }
            }
            if is_valid_row {
                return r_idx as i32;
            }
        }

        -1
    }
}