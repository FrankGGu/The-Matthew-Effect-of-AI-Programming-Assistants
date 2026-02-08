impl Solution {
    pub fn min_cost(start_pos: Vec<i32>, home_pos: Vec<i32>, row_costs: Vec<i32>, col_costs: Vec<i32>) -> i32 {
        let (mut x, mut y) = (start_pos[0], start_pos[1]);
        let (home_x, home_y) = (home_pos[0], home_pos[1]);
        let mut cost = 0;

        while x != home_x {
            if x < home_x {
                x += 1;
            } else {
                x -= 1;
            }
            cost += row_costs[x as usize];
        }

        while y != home_y {
            if y < home_y {
                y += 1;
            } else {
                y -= 1;
            }
            cost += col_costs[y as usize];
        }

        cost
    }
}