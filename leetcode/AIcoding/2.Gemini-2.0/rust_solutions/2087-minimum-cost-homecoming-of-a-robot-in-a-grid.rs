impl Solution {
    pub fn min_cost(
        start_pos: Vec<i32>,
        home_pos: Vec<i32>,
        row_costs: Vec<i32>,
        col_costs: Vec<i32>,
    ) -> i32 {
        let mut cost = 0;
        let mut row_start = start_pos[0];
        let mut row_end = home_pos[0];
        let mut col_start = start_pos[1];
        let mut col_end = home_pos[1];

        if row_start > row_end {
            std::mem::swap(&mut row_start, &mut row_end);
        }

        if col_start > col_end {
            std::mem::swap(&mut col_start, &mut col_end);
        }

        for i in (row_start + 1)..=row_end {
            cost += row_costs[i as usize];
        }

        for i in (col_start + 1)..=col_end {
            cost += col_costs[i as usize];
        }

        cost
    }
}