impl Solution {
    pub fn maximum_score(grid: Vec<Vec<i32>>) -> i64 {
        let m = grid.len();
        let n = grid[0].len();

        let mut score_group_even_sum_indices = 0i64;
        let mut score_group_odd_sum_indices = 0i64;

        for r in 0..m {
            for c in 0..n {
                let val = grid[r][c];
                let abs_val = val.abs() as i64;

                if (r + c) % 2 == 0 {
                    score_group_even_sum_indices += abs_val;
                } else {
                    score_group_odd_sum_indices += abs_val;
                }
            }
        }

        score_group_even_sum_indices.max(score_group_odd_sum_indices)
    }
}