impl Solution {
    pub fn min_cost(start_pos: Vec<i32>, home_pos: Vec<i32>, row_costs: Vec<i32>, col_costs: Vec<i32>) -> i64 {
        let sr = start_pos[0];
        let sc = start_pos[1];
        let hr = home_pos[0];
        let hc = home_pos[1];

        let mut total_cost: i64 = 0;

        if sr < hr {
            for r in (sr + 1)..=hr {
                total_cost += row_costs[r as usize] as i64;
            }
        } else if sr > hr {
            for r in (hr)..=(sr - 1) {
                total_cost += row_costs[r as usize] as i64;
            }
        }

        if sc < hc {
            for c in (sc + 1)..=hc {
                total_cost += col_costs[c as usize] as i64;
            }
        } else if sc > hc {
            for c in (hc)..=(sc - 1) {
                total_cost += col_costs[c as usize] as i64;
            }
        }

        total_cost
    }
}