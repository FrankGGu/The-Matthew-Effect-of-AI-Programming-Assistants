pub fn grid_game(grid: Vec<Vec<i32>>) -> f64 {
    let n = grid.len();
    let mut prefix_sum_row1 = vec![0; n + 1];
    let mut prefix_sum_row2 = vec![0; n + 1];

    for i in 0..n {
        prefix_sum_row1[i + 1] = prefix_sum_row1[i] + grid[0][i];
        prefix_sum_row2[i + 1] = prefix_sum_row2[i] + grid[1][i];
    }

    let mut min_score = i32::MAX;

    for i in 0..n {
        let score = prefix_sum_row2[n] - prefix_sum_row2[i + 1];
        let max_score = prefix_sum_row1[i];
        min_score = min_score.min(score.max(max_score));
    }

    min_score as f64 / 2.0
}