use std::collections::HashMap;

impl Solution {
    pub fn max_increasing_cells(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        let mut cells: Vec<(i32, usize, usize)> = Vec::new();
        for i in 0..m {
            for j in 0..n {
                cells.push((mat[i][j], i, j));
            }
        }

        cells.sort();

        let mut row_dp: Vec<i32> = vec![0; m];
        let mut col_dp: Vec<i32> = vec![0; n];
        let mut cache: HashMap<(usize, usize), i32> = HashMap::new();
        let mut ans = 0;

        for (val, r, c) in cells {
            let mut current_max = 1;
            current_max = current_max.max(row_dp[r] + 1);
            current_max = current_max.max(col_dp[c] + 1);

            cache.insert((r, c), current_max);
            row_dp[r] = row_dp[r].max(current_max);
            col_dp[c] = col_dp[c].max(current_max);
            ans = ans.max(current_max);
        }

        ans
    }
}