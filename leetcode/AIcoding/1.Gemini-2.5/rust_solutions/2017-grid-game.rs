impl Solution {
    pub fn grid_game(grid: Vec<Vec<i32>>) -> i64 {
        let n = grid[0].len();

        let mut row0_prefix_sum: Vec<i64> = vec![0; n + 1];
        let mut row1_prefix_sum: Vec<i64> = vec![0; n + 1];

        for j in 0..n {
            row0_prefix_sum[j + 1] = row0_prefix_sum[j] + grid[0][j] as i64;
            row1_prefix_sum[j + 1] = row1_prefix_sum[j] + grid[1][j] as i64;
        }

        let mut min_max_score: i64 = i64::MAX;

        let total_sum_row0 = row0_prefix_sum[n];

        for i in 0..n {
            let score_top_right = total_sum_row0 - row0_prefix_sum[i + 1];
            let score_bottom_left = row1_prefix_sum[i];

            let current_r2_max_score = score_top_right.max(score_bottom_left);

            min_max_score = min_max_score.min(current_r2_max_score);
        }

        min_max_score
    }
}