impl Solution {
    pub fn min_path_cost(grid: Vec<Vec<i32>>, move_cost: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp_prev: Vec<i32> = grid[0].clone();

        for r in 1..m {
            let mut dp_curr: Vec<i32> = vec![0; n];
            for c in 0..n {
                let mut min_cost_from_prev_row = i32::MAX;
                for prev_c in 0..n {
                    let val_at_prev_cell = grid[r - 1][prev_c] as usize;
                    let cost_to_move = move_cost[val_at_prev_cell][c];
                    let total_cost_to_reach_prev_c_and_move = dp_prev[prev_c] + cost_to_move;
                    min_cost_from_prev_row = min_cost_from_prev_row.min(total_cost_to_reach_prev_c_and_move);
                }
                dp_curr[c] = grid[r][c] + min_cost_from_prev_row;
            }
            dp_prev = dp_curr;
        }

        *dp_prev.iter().min().unwrap()
    }
}