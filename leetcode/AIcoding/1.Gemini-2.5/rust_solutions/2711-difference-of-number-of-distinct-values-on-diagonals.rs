use std::collections::HashSet;

impl Solution {
    pub fn difference_of_distinct_values(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();

        let mut ans = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                // Calculate distinct values in the top-left diagonal
                let mut tl_set = HashSet::new();
                let mut r_tl = i as isize - 1;
                let mut c_tl = j as isize - 1;
                while r_tl >= 0 && c_tl >= 0 {
                    tl_set.insert(grid[r_tl as usize][c_tl as usize]);
                    r_tl -= 1;
                    c_tl -= 1;
                }
                let tl_count = tl_set.len() as i32;

                // Calculate distinct values in the bottom-right diagonal
                let mut br_set = HashSet::new();
                let mut r_br = i as isize + 1;
                let mut c_br = j as isize + 1;
                while r_br < m as isize && c_br < n as isize {
                    br_set.insert(grid[r_br as usize][c_br as usize]);
                    r_br += 1;
                    c_br += 1;
                }
                let br_count = br_set.len() as i32;

                ans[i][j] = (tl_count - br_count).abs();
            }
        }

        ans
    }
}