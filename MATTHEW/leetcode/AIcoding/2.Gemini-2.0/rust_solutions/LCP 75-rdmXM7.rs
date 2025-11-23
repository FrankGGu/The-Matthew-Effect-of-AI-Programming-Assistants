impl Solution {
    pub fn min_cost(start_pos: Vec<i32>, home_pos: Vec<i32>, row_costs: Vec<i32>, col_costs: Vec<i32>) -> i32 {
        let mut cost = 0;
        let start_row = start_pos[0];
        let start_col = start_pos[1];
        let home_row = home_pos[0];
        let home_col = home_pos[1];

        if start_row < home_row {
            for i in (start_row + 1)..=home_row {
                cost += row_costs[i as usize]
            }
        } else if start_row > home_row {
            for i in (home_row..start_row).rev() {
                cost += row_costs[i as usize]
            }
        }

        if start_col < home_col {
            for i in (start_col + 1)..=home_col {
                cost += col_costs[i as usize]
            }
        } else if start_col > home_col {
            for i in (home_col..start_col).rev() {
                cost += col_costs[i as usize]
            }
        }

        cost
    }
}