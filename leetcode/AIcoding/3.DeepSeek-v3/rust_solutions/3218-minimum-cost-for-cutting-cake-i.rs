impl Solution {
    pub fn minimum_cost_cutting_cake_i(cake: Vec<Vec<i32>>) -> i32 {
        let mut rows = cake.len();
        let mut cols = if rows > 0 { cake[0].len() } else { 0 };
        let mut row_cuts = Vec::new();
        let mut col_cuts = Vec::new();

        for i in 0..rows {
            for j in 0..cols {
                if cake[i][j] == 1 {
                    row_cuts.push(i as i32);
                    col_cuts.push(j as i32);
                }
            }
        }

        if row_cuts.is_empty() {
            return 0;
        }

        row_cuts.sort();
        col_cuts.sort();

        let median_row = row_cuts[row_cuts.len() / 2];
        let median_col = col_cuts[col_cuts.len() / 2];

        let mut cost = 0;
        for &r in &row_cuts {
            cost += (r - median_row).abs();
        }
        for &c in &col_cuts {
            cost += (c - median_col).abs();
        }

        cost
    }
}